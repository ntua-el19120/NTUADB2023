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
      SELECT WriterName
      FROM book_writers as bw
      EXCEPT
      SELECT DISTINCT bw.WriterName
      FROM book_writers as bw
      INNER JOIN Borrowing ON bw.ISBN = Borrowing.ISBN;
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
          <title>Authors with 0 Rentals</title>
          <style>
            body {
              font-family: Arial, sans-serif;
              background-color: #f4f4f4;
            }
            
            h1, h2 {
              text-align: center;
              color: #333;
            }

            .container {
              max-width: 800px;
              margin: 0 auto;
              padding: 20px;
            }

            table {
              border-collapse: collapse;
              width: 100%;
              margin-bottom: 20px;
            }

            th, td {
              border: 1px solid #ddd;
              padding: 8px;
              text-align: left;
            }

            th {
              background-color: #808285;
              color: #fff;
            }
            
            .back-button {
              display: inline-block;
              padding: 8px 16px;
              font-size: 14px;
              font-weight: bold;
              text-decoration: none;
              background-color: #4CAF50;
              color: #fff;
              border: none;
              border-radius: 4px;
            }
            
            .back-button::before {
              content: '←';
              margin-right: 5px;
            }
          </style>
        </head>
        <body>
          <div class="container">
            <h1>Unlucky Authors</h1>
            <table>
              <thead>
                <tr>
                  <th>Author Name</th>
                </tr>
              </thead>
              <tbody>
      `;

      // Append rows to the HTML table
      for (const row of results) {
        htmlTable += `
          <tr>
            <td>${row.WriterName}</td>
          </tr>
        `;
      }

      // Complete the HTML table
      htmlTable += `
              </tbody>
            </table>
            <h3><a href="http://localhost:9103/libq/generaladmin" class="back-button">Back to the homepage</a></h3>
          </div>
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
