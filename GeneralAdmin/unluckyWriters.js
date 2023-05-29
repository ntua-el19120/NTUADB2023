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

    let query = 'SELECT TeacherName, A.count AS TotalBorrowings FROM Teacher INNER JOIN ( SELECT IDUsers, COUNT(*) AS count FROM Borrowing GROUP BY IDUsers ) AS A ON Teacher.IDUsers = A.IDUsers WHERE Teacher.BirthDate > DATE_SUB(CURDATE(), INTERVAL 40 YEAR) ORDER BY A.count DESC';
    

    connection.query(query, (err, results) => {
        if (err) throw err;
        res.json(results);
      });
  
        connection.release();
      });
    });
module.exports = router;