const express = require('express');
const router = express.Router();
const pool = require('../connect');

router.get('/', function (req, res) {
  pool.getConnection((err, connection) => {
    if (err) {
      console.error('Error connecting to database:', err);
      res.status(500).send('Internal Server Error');
      return;
    }
    
    const query = `
      SELECT b.*,
        GROUP_CONCAT(DISTINCT bc.Category SEPARATOR ', ') AS Categories,
        GROUP_CONCAT(DISTINCT bk.Keyword SEPARATOR ', ') AS Keywords
      FROM book AS b
      JOIN availability AS a ON b.ISBN = a.ISBN
      LEFT JOIN book_categories AS bc ON b.ISBN = bc.ISBN
      LEFT JOIN book_keywords AS bk ON b.ISBN = bk.ISBN
      WHERE EXISTS (
        SELECT 1
        FROM student AS s
        WHERE s.IdUsers = 1 AND a.IdSchool = s.IdSchool
      )
      OR EXISTS (
        SELECT 1
        FROM teacher AS t
        WHERE t.IdUsers = 1 AND a.IdSchool = t.IdSchool
      )
      GROUP BY b.ISBN;
    `;
    
    connection.query(query, (error, results) => {
      connection.release(); // Release the connection
      
      if (error) {
        console.error('Error executing query:', error);
        res.status(500).send('Internal Server Error');
        return;
      }
      
      const tableRows = results.map(book => `
        <tr>
          <td>${book.ISBN}</td>
          <td>${book.Title}</td>
          <td>${book.Publisher}</td>
          <td>${book.PageNumber}</td>
          <td>${book.Summary}</td>
          <td><img src="${book.Picture}" alt="Book Cover" height="100"></td>
          <td>${book.Language}</td>
          <td>${book.Rating}</td>
          <td>${book.Categories}</td>
          <td>${book.Keywords}</td>
        </tr>
      `).join('');
      
      const html = `
        <!DOCTYPE html>
        <html>
        <head>
          <title>Books</title>
          <style>
            body {
              font-family: Arial, sans-serif;
              background-color: #f4f4f4;
              padding: 20px;
            }
            
            h1 {
              text-align: center;
              color: #333;
              margin-bottom: 20px;
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
              margin-top: 20px;
            }
            .back-button::before {
              content: '←';
              margin-right: 5px;
            }

            .action-buttons {
              display: flex;
              gap: 10px;
            }

            .delete-button {
              background-color: #f44336;
            }

          </style>
        </head>
        <body>
          <h1>Books</h1>
          <table>
            <thead>
              <tr>
                <th>ISBN</th>
                <th>Title</th>
                <th>Publisher</th>
                <th>Page Number</th>
                <th>Summary</th>
                <th>Picture</th>
                <th>Language</th>
                <th>Rating</th>
                <th>Categories</th>
                <th>Keywords</th>
              </tr>
            </thead>
            <tbody>
              ${tableRows}
            </tbody>
          </table>
          <a class="back-button" href="/">Back</a>
        </body>
        </html>
      `;
      
      res.send(html); // Send the HTML response
    });
  });
});

module.exports = router;
