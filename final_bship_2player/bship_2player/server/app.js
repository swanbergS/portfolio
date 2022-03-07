/**
 * Sophia Swanberg
 * Battleship Part 4
 * Server-Side
 */
//include the express module
const express = require('express');
//include the cors module
const cors = require('cors');
//use the routes module
var routes = require('./routes.js');
const app = express();
//specify port
const port = 3000;
//allows for parsing post-bodies
const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
//Apply CORS to allow cross origin access
app.use(cors());
//use routes modue for /
app.use('/', routes);
app.listen(port, () => console.log("Server is running!"));