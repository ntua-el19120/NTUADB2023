const express = require('express');
const router = express.Router();
const pool = require('../connect');


router.get('/', function (req, res) {


    pool.getConnection(function (err, connection) {
      if (err) {
        console.error('Error getting database connection:', err);
        res.status(500).json({ error: 'An error occurred while getting a database connection' });
        return;
      }

    let query = 'SELECT `category1`, `category2`, COUNT(*) AS `count` FROM ( SELECT b1.ISBN, b1.Category AS `category1`, b2.Category AS `category2` FROM Book_Categories as b1 JOIN Book_Categories as b2 ON b1.ISBN = b2.ISBN AND b1.Category < b2.Category JOIN borrowing bor ON b1.ISBN = bor.ISBN ) AS book3_categories GROUP BY `category1`, `category2` ORDER BY `count` DESC LIMIT 3';
    

    connection.query(query, (err, results) => {
        if (err) throw err;
        res.json(results);
      });
  
        connection.release();
      });
    });
module.exports = router;