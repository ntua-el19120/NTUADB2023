const express = require('express');
const router = express.Router();
const pool = require('../connect');

router.get('/', function (req, res) {
  const { Category, Title, Publisher } = req.query;

  let conditions = [];
  let values = [];

  if (Title) {
    conditions.push('Title = ?');
    values.push(Title);
  }

  if (Category) {
    conditions.push('Category = ?');
    values.push(Category);
  }

  if (Publisher) {
    conditions.push('Publisher = ?');
    values.push(Publisher);
  }

  pool.getConnection(function (err, connection) {
    if (err) {
      console.error('Error getting database connection:', err);
      res.status(500).json({ error: 'An error occurred while getting a database connection' });
      return;
    }

    let query = `
    SELECT
    ISBN,
    Title,
    Publisher,
    PageNumber,
    Summary,
    Picture,
    Language,
    Rating,
    AvailableCopies,
    Categories
  FROM
    book_combined_view
    `;

    if (conditions.length > 0) {
      const whereClause = conditions.join(' AND ');
      query += ' WHERE ' + whereClause + ' order by Title  ';
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
