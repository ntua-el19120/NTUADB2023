const express = require('express');
const router = express.Router();
const pool = require('../connect');

router.get('/', function (req, res) {
  const { Category } = req.query;

  let conditions = [];
  let values = [];

  if (Category) {
    conditions.push('Category = ?');
    values.push(Category);
  }

  pool.getConnection(function (err, connection) {
    if (err) {
      console.error('Error getting database connection:', err);
      res.status(500).json({ error: 'An error occurred while getting a database connection' });
      return;
    }

    let query = `
      SELECT DISTINCT book_writers.WriterName AS WriterName, Teacher.TeacherName AS TeacherName
      FROM book_categories
      INNER JOIN book_writers ON book_categories.ISBN = book_writers.ISBN
      INNER JOIN Borrowing ON book_categories.ISBN = Borrowing.ISBN
      INNER JOIN Teacher ON Borrowing.IDUsers = Teacher.IDUsers
    `;

    if (conditions.length > 0) {
      const whereClause = conditions.join(' AND ');
      query += ' WHERE ' + whereClause + '  AND Borrowing.BorrowDate > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)';
    }

    connection.query(query, values, (err, results) => {
      if (err) {
        console.error('Error executing query:', err);
        res.status(500).json({ error: 'An error occurred while executing the query' });
        return;
      }
      res.json(results);
    });

    connection.release();
  });
});

module.exports = router;
