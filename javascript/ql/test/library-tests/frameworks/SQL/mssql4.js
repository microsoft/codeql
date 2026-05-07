// Tests destructured imports from mssql, where query/batch are called as standalone functions
const { connect, query, batch, Request } = require('mssql');

async () => {
    await connect('mssql://username:password@localhost/database');
    const result = await query('SELECT 123'); // $ SqlString
    const result2 = await batch('CREATE PROCEDURE #tmp AS SELECT * FROM t'); // $ SqlString
}
