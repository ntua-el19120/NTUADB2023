const express = require('express');
const router = express.Router();
const pool = require('../connect');

router.get('/', function (req, res) {
  const { Category } = req.query;

  pool.getConnection(function (err, connection) {
    if (err) {
      console.error('Error getting database connection:', err);
      res.status(500).json({ error: 'An error occurred while getting a database connection' });
      return;
    }

    let query = `
    SELECT category1, category2, COUNT(*) AS count
    FROM (
        SELECT b1.ISBN, b1.Category AS category1, b2.Category AS category2
        FROM Book_Categories as b1
        JOIN Book_Categories as b2 ON b1.ISBN = b2.ISBN AND b1.Category < b2.Category
        JOIN borrowing bor ON b1.ISBN = bor.ISBN
    ) AS book3_categories
    GROUP BY category1, category2
    ORDER BY count DESC
    LIMIT 3;
    `;

    connection.query(query, (err, results) => {
      if (err) {
        console.error('Error executing query:', err);
        res.status(500).json({ error: 'An error occurred while executing the query' });
        return;
      }

      // Generate HTML table
      let htmlTable = `
        <!DOCTYPE html>
        <html>
        <head>
          <title>3.1.6 Query</title>
          <style>
            /* CSS for the table and scrolling */
            #results-table {
              width: 100%;
              border-collapse: collapse;
              table-layout: fixed;
            }
          
            #results-table th,
            #results-table td {
              padding: 8px;
              border: 1px solid #ddd;
            }
          
            #results-container {
              max-height: 300px;
              overflow-y: scroll;
            }
          </style>
        </head>
        <body>
          <h1>Top 3 pairs!</h1>
          <div id="results-container">
            <table id="results-table">
              <thead>
                <tr>
                  <th>Category 1</th>
                  <th>Category 2</th>
                  <th>Number of Borrowings</th>

                </tr>
              </thead>
              <tbody>
      `;

      // Append rows to the HTML table
      for (const row of results) {
        htmlTable += `
          <tr>
            <td>${row.category1}</td>
            <td>${row.category2}</td>
            <td>${row.count}</td>


          </tr>
        `;
      }

      // Complete the HTML table
      htmlTable += `
              </tbody>
            </table>
          </div>
        </body>
        <h3><a href="http://localhost:9103/libq/generaladmin">Back to the homepage</a></h3></li>
        </html>
      `;

      // Send the HTML response
      res.send(htmlTable);

      connection.release();
    });
  });
});

module.exports = router;




