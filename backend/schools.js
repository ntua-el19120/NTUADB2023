const express = require('express');
const router = express.Router();
const pool = require('./connect.js');

router.get('/', (req, res) => {
  const query = 'SELECT * FROM SchoolUnit';

  // Execute the MySQL query
  pool.getConnection((err, connection) => {
    if (err) {
      console.error('Error connecting to the database:', err);
      return res.status(500).send('Internal Server Error');
    }

    connection.query(query, (err, results) => {
      connection.release(); // Release the connection back to the pool

      if (err) {
        console.error('Error executing the query:', err);
        return res.status(500).send('Internal Server Error');
      }

      // Send the retrieved school data as the response
      res.send(results);
    });
  });
});

module.exports = router;
