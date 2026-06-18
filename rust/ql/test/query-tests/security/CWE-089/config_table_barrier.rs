use sqlx::PgPool;

/// Configuration for an aggregate's tables — initialized from application
/// config at startup, not from per-request user data.
struct AggregateTableConfig {
    events_table: String,
    snapshots_table: String,
    view_table: String,
    collection: String,
    schema_name: String,
    index_name: String,
    bucket: String,
}

impl AggregateTableConfig {
    fn new(aggregate_name: &str) -> Self {
        Self {
            events_table: format!("{}_events", aggregate_name),
            snapshots_table: format!("{}_snapshots", aggregate_name),
            view_table: format!("{}_view", aggregate_name),
            collection: format!("{}_collection", aggregate_name),
            schema_name: format!("{}_schema", aggregate_name),
            index_name: format!("{}_idx", aggregate_name),
            bucket: format!("{}_bucket", aggregate_name),
        }
    }

    /// Uses table-name fields in SQL — these should NOT be flagged because
    /// the field names match config-derived table-name patterns.
    async fn delete_aggregate(
        &self,
        pool: &PgPool,
        aggregate_id: &str,
    ) -> Result<u64, sqlx::Error> {
        // self.events_table is a config-derived table name (barrier should block)
        sqlx::query(&format!( // $ sql-sink
            "DELETE FROM {} WHERE aggregate_id = $1",
            self.events_table // safe: config-derived table name
        ))
        .bind(aggregate_id)
        .execute(pool)
        .await?;

        // self.snapshots_table is a config-derived table name (barrier should block)
        sqlx::query(&format!( // $ sql-sink
            "DELETE FROM {} WHERE aggregate_id = $1",
            self.snapshots_table // safe: config-derived table name
        ))
        .bind(aggregate_id)
        .execute(pool)
        .await?;

        // self.view_table is a config-derived table name (barrier should block)
        let result = sqlx::query(&format!( // $ sql-sink
            "DELETE FROM {} WHERE view_id = $1",
            self.view_table // safe: config-derived table name
        ))
        .bind(aggregate_id)
        .execute(pool)
        .await?;

        Ok(result.rows_affected())
    }

    /// Uses other config-derived field names — also should not be flagged.
    async fn query_collection(
        &self,
        pool: &PgPool,
    ) -> Result<(), sqlx::Error> {
        sqlx::query(&format!( // $ sql-sink
            "SELECT * FROM {}",
            self.collection // safe: config-derived collection name
        ))
        .execute(pool)
        .await?;

        sqlx::query(&format!( // $ sql-sink
            "SELECT * FROM {}.my_table",
            self.schema_name // safe: config-derived schema name
        ))
        .execute(pool)
        .await?;

        sqlx::query(&format!( // $ sql-sink
            "CREATE INDEX {} ON my_table (col)",
            self.index_name // safe: config-derived index name
        ))
        .execute(pool)
        .await?;

        sqlx::query(&format!( // $ sql-sink
            "SELECT * FROM {}",
            self.bucket // safe: config-derived bucket name
        ))
        .execute(pool)
        .await?;

        Ok(())
    }
}

/// A struct where a field is NOT a table-name pattern — should still be flagged.
struct UnsafeConfig {
    user_input: String,
}

impl UnsafeConfig {
    async fn unsafe_query(
        &self,
        pool: &PgPool,
    ) -> Result<(), sqlx::Error> {
        // self.user_input does NOT match the barrier pattern, so taint propagates
        sqlx::query(&format!( // $ sql-sink Alert[rust/sql-injection]=remote_config
            "SELECT * FROM users WHERE name = '{}'",
            self.user_input // unsafe: not a table-name field
        ))
        .execute(pool)
        .await?;

        Ok(())
    }
}

async fn test_config_table_barrier(pool: &PgPool) {
    let remote_string = reqwest::blocking::get("http://example.com/") // $ Source=remote_config
        .unwrap()
        .text()
        .unwrap_or(String::from(""));

    // Config initialized from remote — but field accesses with table-name
    // patterns should still be blocked by the barrier.
    let config = AggregateTableConfig::new(&remote_string);
    let _ = config.delete_aggregate(pool, "some-id").await;
    let _ = config.query_collection(pool).await;

    // Unsafe config — field name doesn't match table pattern, should alert.
    let unsafe_cfg = UnsafeConfig {
        user_input: remote_string.clone(),
    };
    let _ = unsafe_cfg.unsafe_query(pool).await;
}
