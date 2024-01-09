// Import pg.Pool
const Pool = require("pg").Pool;

// Define parameters
const user = "ios";
const host = "localhost";
const password = "ios";
const database = "ios_s5";
const port = 5432;

// Define a pool
const pool = new Pool({
  user: user,
  host: host,
  password: password,
  database: database,
  port: port,
});

// Exports
module.exports = pool;

//psql -h localhost -U ios ios_s5