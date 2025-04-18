var express = require('express');

var fs = require('fs');
var child_process = require('child_process');
var mysql = require('mysql');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'me',
  password : 'secret',
  database : 'my_db'
});
connection.connect();
 
function expensiveHandler1(req, res) { login(); }
function expensiveHandler2(req, res) { fs.writeFileSync("log", "request"); }
function expensiveHandler3(req, res) { child_process.exec("/bin/true"); }
function expensiveHandler4(req, res) { connection.query('SELECT 1 + 1 AS solution'); }
function inexpensiveHandler(req, res) { res.send("Hi"); }

function mkSubRouter1() {
  var router = new express.Router();
  router.get('/:path', expensiveHandler1); // $ Alert
  return router;
}

function mkSubRouter2() {
  var router = new express.Router();
  router.get('/:path', expensiveHandler1);
  return router;
}

var app1 = express();

// no rate limiting
app1.get('/:path', expensiveHandler1);  // $ Alert
app1.get('/:path', expensiveHandler2);  // $ Alert
app1.get('/:path', expensiveHandler3);  // $ Alert
app1.get('/:path', expensiveHandler4);  // $ Alert
app1.get('/:path', inexpensiveHandler);
app1.use(mkSubRouter1());

// rate limiting using express-rate-limit
var RateLimit = require('express-rate-limit');
var limiter = new RateLimit();
app1.use(limiter);
app1.get('/:path', expensiveHandler1);
app1.get('/:path', expensiveHandler2);
app1.get('/:path', expensiveHandler3);
app1.get('/:path', expensiveHandler4);
app1.get('/:path', inexpensiveHandler);
app1.use(mkSubRouter2());

// rate limiting using express-brute
var app2 = express();
var ExpressBrute = require('express-brute');
var bruteforce = new ExpressBrute();
app2.get('/:path', bruteforce.prevent, expensiveHandler1);

// rate limiting using express-limiter
var app3 = express();
require('express-limiter')(app3)({ method: 'get', path: '/' });
app3.get('/:path', expensiveHandler1);

express().get('/:path', function(req, res) { verifyUser(req); });  // $ Alert
express().get('/:path', RateLimit(), function(req, res) { verifyUser(req); });

// rate limiting using rate-limiter-flexible
const { RateLimiterRedis } = require('rate-limiter-flexible');
const rateLimiter = new RateLimiterRedis();
const rateLimiterMiddleware = (req, res, next) => {
  rateLimiter.consume(req.ip).then(next).catch(res.status(429).send('rate limited'));
};
express().get('/:path', rateLimiterMiddleware, expensiveHandler1);

const catchAsync = fn => (...args) => fn(...args).catch(args[2]);
express().get('/:path', catchAsync(expensiveHandler1)); // $ Alert
express().get('/:path', rateLimiterMiddleware, catchAsync(expensiveHandler1));
express().get('/:path', catchAsync(rateLimiterMiddleware), expensiveHandler1);
express().get('/:path', catchAsync(rateLimiterMiddleware), catchAsync(expensiveHandler1));

function errorHandler(req, res, next) {
  next(makeOAuthError(req, res));
}
express().use(errorHandler); // OK - does not perform authentication

const fastifyApp = require('fastify')();

fastifyApp.get('/foo', expensiveHandler1); // $ Alert
fastifyApp.register(require('fastify-rate-limit'));
fastifyApp.get('/bar', expensiveHandler1);
