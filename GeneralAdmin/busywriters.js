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

    let query =`
    SELECT BW.WriterName as WriterName
    FROM (
        SELECT WriterName, COUNT(ISBN) AS TotalBooks
        FROM Book_Writers
        GROUP BY WriterName
    ) AS BW
    WHERE BW.TotalBooks >= (SELECT MAX(TotalBooks) FROM (SELECT WriterName, COUNT(ISBN) AS TotalBooks FROM Book_Writers GROUP BY WriterName) AS MaxBooks) - 5;
    `;
    

    connection.query(query, (err, results) => {
        if (err) throw err;
        res.json(results);
      });
  
        connection.release();
      });
    });
module.exports = router;