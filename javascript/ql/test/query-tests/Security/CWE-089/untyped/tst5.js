var express = require('express');
const { connect, query } = require('mssql');

var app = express();
app.get('/user/:id', async function(req, res) {
  await connect('mssql://username:password@localhost/database');
  query("SELECT * FROM users WHERE id = '" + req.params.id + "'"); // $ Alert
});
