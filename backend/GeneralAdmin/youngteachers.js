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
      SELECT TeacherName, A.count AS TotalBorrowings
      FROM Teacher
      INNER JOIN (
        SELECT IDUsers, COUNT(*) AS count
        FROM Borrowing
        GROUP BY IDUsers
      ) AS A ON Teacher.IDUsers = A.IDUsers
      WHERE Teacher.BirthDate > DATE_SUB(CURDATE(), INTERVAL 40 YEAR)
      ORDER BY TotalBorrowings DESC;
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
          <title>Teacher Borrowings</title>
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
          <h1>Teacher Borrowings</h1>
          <div id="results-container">
            <table id="results-table">
              <thead>
                <tr>
                  <th>Teacher Name</th>
                  <th>Total Borrowings</th>
                </tr>
              </thead>
              <tbody>
      `;

      // Append rows to the HTML table
      for (const row of results) {
        htmlTable += `
          <tr>
            <td>${row.TeacherName}</td>
            <td>${row.TotalBorrowings}</td>
          </tr>
        `;
      }

      // Complete the HTML table
      htmlTable += `
              </tbody>
            </table>
          </div>
          <h3><a href="http://localhost:9103/libq/generaladmin">Back to the homepage</a></h3></li>

        </body>
        </html>
      `;

      // Send the HTML response
      res.send(htmlTable);

      connection.release();
    });
  });
});

module.exports = router;