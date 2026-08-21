use axum::{extract::Query, response::Html, routing::get, Router};

#[derive(serde::Deserialize)]
struct GreetingParams {
    name: String,
    external_domain: String,
}

struct ServerConfig {
    external_domain: String,
}

async fn greet_handler(Query(params): Query<GreetingParams>) -> Html<String> {
    let html_content = format!("<p>Hello, {}!</p>", params.name);
    Html(html_content) // $ Alert[rust/xss]=greet
}

async fn request_host_handler(Query(params): Query<GreetingParams>) -> Html<String> {
    Html(format!("<p>Host: {}!</p>", params.external_domain)) // $ Alert[rust/xss]=requestHost
}

async fn config_host_handler() -> Html<String> {
    let config = ServerConfig {
        external_domain: std::env::var("EXTERNAL_DOMAIN").unwrap(),
    };
    Html(format!("<p>Host: {}!</p>", config.external_domain))
}

async fn environment_handler() -> Html<String> {
    let value = std::env::var("HTML").unwrap(); // $ Source=environment
    Html(format!("<p>{value}</p>")) // $ Alert[rust/xss]=environment
}

#[tokio::main]
pub async fn main() {
    let app = Router::<()>::new()
        .route("/greet", get(greet_handler)) // $ Source=greet
        .route("/request-host", get(request_host_handler)) // $ Source=requestHost
        .route("/config-host", get(config_host_handler))
        .route("/environment", get(environment_handler));
    let listener = tokio::net::TcpListener::bind("127.0.0.1:3000")
        .await
        .unwrap();
    axum::serve(listener, app).await.unwrap();
}