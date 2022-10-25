// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

const express = require('express');
const app = express();
let cors = require('cors');
const AWS = require('aws-sdk');
const port = 3001;
const dotenv = require('dotenv');
const { Pool } = require('pg');
dotenv.config();

app.use(cors());

let swagger = require('./swagger/swagger');
app.use('/api/docs', swagger.router);

/**
 * @swagger
 * /status:
 *   get:
 *     description: Dummy endpoint used as an API health check
 *     tags:
 *       - Status
 *     produces:
 *       - application/json
 *     responses:
 *       200:
 *         description: Retrieves a string with a health status
 */
app.get('/status', (req, res) => {
  res.send({
    message: 'AWS Demo server is up and running!',
  });
});

/**
 * @swagger
 * /api/getDBStatus:
 *   get:
 *     description: Get DB status
 *     tags:
 *       - DBStatus
 *     produces:
 *       - application/json
 *     responses:
 *       200:
 *         description: Retrieves db status
 */
app.get('/api/getDBStatus', async (req, res) => {
  // connect to psql
  try {
    const pool = new Pool({
      user: process.env.DB_USER,
      host: process.env.DB_HOST,
      database: process.env.DB_NAME,
      password: process.env.DB_PASSWORD,
      port: process.env.DB_PORT,
    });

    await pool.connect();
    const resp = await pool.query('SELECT * FROM pg_catalog.pg_tables;');
    // await pool.end();
    res.send({
      resp,
      message: 'hey'
    });
  } catch (error) {
    console.log(error);
  }
});

/**
 * @swagger
 * /api/getAllProducts:
 *   get:
 *     description: Retrieves all products available in the Dynamodb table
 *     tags:
 *       - Products
 *     produces:
 *       - application/json
 *     responses:
 *       200:
 *         description: Retrieves a list of products
 */
app.get('/api/getAllProducts', (req, res) => {
  let AB3_TABLE = 'DYNAMODB_TABLE'; //DYNAMODB_TABLE value is retrieved from the generated resources created by the terraform code
  const docClient = new AWS.DynamoDB.DocumentClient();
  const params = {
    TableName: AB3_TABLE,
  };

  docClient.scan(params, function (err, data) {
    if (err) {
      res.send({
        code: err.status,
        description: err.message,
      });
    } else {
      let products = data.Items;
      res.send({
        products,
      });
    }
  });
});

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  let err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handler
app.use(function (err, req, res, next) {
  console.error(`Error catched! ${err}`);

  let error = {
    code: err.status,
    description: err.message,
  };
  status: err.status || 500;

  res.status(error.code).send(error);
});

app.listen(port);
console.log('Server started on port ' + port);
