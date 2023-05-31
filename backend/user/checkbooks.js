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

    let query1 = `
    SELECT persons_per_school_view.IdSchool
    FROM persons_per_school_view
    JOIN LoggedUSer ON persons_per_school_view.PersonId = LoggedUSer.IdLogged;
    `;

    connection.query(query1, (err, results) => {
      if (err) {
        console.error('Error executing query:', err);
        res.status(500).json({ error: 'An error occurred while executing the query' });
        return;
      }

      // Assuming the query returns a single row with the `IdSchool` column
      const idSchool = results[0].IdSchool;

      let query = `
        SELECT DISTINCT
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
        WHERE
          IdSchool = ?`;

      if (conditions.length > 0) {
        const whereClause = conditions.join(' AND ');
        query += ' AND ' + whereClause + ' ORDER BY Title';
      }

      connection.query(query, [idSchool, ...values], (err, results) => {
        if (err) {
          console.error('Error executing query:', err);
          res.status(500).json({ error: 'An error occurred while executing the query' });
          return;
        }
        res.json(results);
      });
    });

    connection.release();
  });
});

module.exports = router;
