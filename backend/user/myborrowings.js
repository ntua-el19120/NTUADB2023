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

    let query1 = 'SELECT idlogged FROM LoggedUser';

    connection.query(query1, (err, results) => {
      if (err) {
        console.error('Error executing query:', err);
        res.status(500).json({ error: 'An error occurred while executing the query' });
        return;
      }

      const idlogged = results[0].idlogged;

      let query2 = `
      SELECT DISTINCT B.Title as Title, B.ISBN as ISBN, B.RATING as RATING, A.ReviewText AS ReviewText, A.RatingLikert AS RatingLikert
      FROM book_combined_view AS B, NewTable AS A
        WHERE PersonId = ? AND A.ISBN = B.ISBN
      `;

      connection.query(query2, [idlogged], (err, results) => {
        if (err) {
          console.error('Error executing query:', err);
          res.status(500).json({ error: 'An error occurred while executing the query' });
          return;
        }

// ...

// Generate HTML table
let htmlTable = `
  <!DOCTYPE html>
  <html>
    <head>
      <title>3.1.6 Query</title>
      <style>
        /* CSS for the table and scrolling */
        #results-container {
          max-height: 400px;
          overflow-y: scroll;
          margin-top: 20px;
        }

        #results-table {
          width: 100%;
          border-collapse: collapse;
        }

        #results-table th,
        #results-table td {
          padding: 10px;
          border: 1px solid #ddd;
        }

        #results-table th {
          background-color: #f2f2f2;
        }

        #results-table td[data-field="ReviewText"],
        #results-table td[data-field="RatingLikert"] {
          text-align: center;
        }

        #results-table td[data-field="ReviewText"]:hover,
        #results-table td[data-field="RatingLikert"]:hover {
          background-color: #f2f2f2;
        }

        .edit-link {
          display: inline-block;
          padding: 5px 10px;
          background-color: #4CAF50;
          color: white;
          text-decoration: none;
          border-radius: 4px;
          transition: background-color 0.3s;
        }

        .edit-link:hover {
          background-color: #45a049;
        }

        .edit-link:active {
          background-color: #3e8e41;
        }

        h1 {
          margin-top: 0;
        }
      </style>
    </head>
    <body>
      <h1>My Borrowings</h1>
      <div id="results-container">
        <table id="results-table">
          <thead>
            <tr>
              <th>Title</th>
              <th>ISBN</th>
              <th>Rating</th>
              <th>Review Text</th>
              <th>Rating Likert</th>
              <th>Edit</th>
            </tr>
          </thead>
          <tbody>
`;

// Append rows to the HTML table
for (const row of results) {
  htmlTable += `
    <tr>
      <td>${row.Title}</td>
      <td>${row.ISBN}</td>
      <td>${row.RATING}</td>
      <td contenteditable="true" data-field="ReviewText">${row.ReviewText}</td>
      <td contenteditable="true" data-field="RatingLikert">${row.RatingLikert}</td>
      <td><a href="/user/updatereview/${idlogged}/${row.ISBN}" class="edit-link">Edit Review</a></td>
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
});

module.exports = router;
