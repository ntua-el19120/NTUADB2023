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
      let b=[];
      b.push(idlogged);
      b.push(idlogged);


      let query2 = `
      SELECT DISTINCT A.Title as Title, A.ISBN as ISBN, A.rating as Rating, R.ReviewText as RatingText, R.RatingLikert as RatingLikert
      FROM (
          SELECT BOR.ISBN as ISBN, B.Title as Title, B.rating as rating, bor.Idusers as id
          FROM borrowing BOR
          JOIN book B ON BOR.ISBN = B.ISBN
          WHERE bor.idusers = ?
      ) A
      LEFT JOIN review R ON A.ISBN = R.ISBN AND R.Idusers = ?;
      
      
      
      `;

      connection.query(query2, b, (err, results) => {
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
              <th>Delete</th>

            </tr>
          </thead>
          <tbody>
`;

// ...

// Append rows to the HTML table
// Append rows to the HTML table
for (const row of results) {
  let textColorClass = row.approval === 1 ? 'approved-text' : 'not-approved-text';
  let ratingText = row.Rating || '<span class="null-value">N/A</span>';
  let reviewText = row.RatingText || '<span class="null-value">N/A</span>';
  let ratingLikertText = row.RatingLikert || '<span class="null-value">N/A</span>';
  htmlTable += `
    <tr>
      <td>${row.Title}</td>
      <td>${row.ISBN}</td>
      <td>${row.Rating}</td>
      <td contenteditable="true" data-field="ReviewText" class="${textColorClass}">${reviewText}</td>
      <td contenteditable="true" data-field="RatingLikert" class="${textColorClass}">${ratingLikertText}</td>
      <td><a href="/libq/user/updatereview/${idlogged}/${row.ISBN}" class="edit-link">Edit Review</a></td>
      <td><a href="#" onclick="deleteReview('${idlogged}', '${row.ISBN}')" class="edit-link">Delete Review</a></td>
    </tr>
  `;
}

htmlTable += `
  <script>
    function deleteReview(userId, isbn) {
      if (confirm('Are you sure you want to delete the review?')) {
        fetch('/libq/user/myborrowings/deletereview/' + userId + '/' + isbn, { method: 'DELETE' })
          .then(response => {
            if (response.ok) {
              // Reload the page after successful deletion
              location.reload();
            } else {
              console.error('Error deleting review:', response.statusText);
              alert('An error occurred while deleting the review. Please try again.');
            }
          })
          .catch(error => {
            console.error('Error deleting review:', error);
            alert('An error occurred while deleting the review. Please try again.');
          });
      }
    }
  </script>
`;

// ...

// Complete the HTML table
htmlTable += `
          </tbody>
        </table>
      </div>
    </body>
    <style>
      .not-approved-text {
        color: red;
      }
      .approved-text {
        color: black;
      }
      .null-value {
        color: green;
      }
    </style>
    <h3>if your review is red it means it is not approved (yet) :)</h3>
    <h3><a href="http://localhost:9103/libq/generaladmin">Back to the homepage</a></h3>
  </html>
`;


        // Send the HTML response
        res.send(htmlTable);

        connection.release();
      });
    });
  });
});





  router.delete('/deletereview/:userId/:isbn', function (req, res) {
    const userId = req.params.userId;
    const isbn = req.params.isbn;
  
    pool.getConnection(function (err, connection) {
      if (err) {
        console.error('Error getting database connection:', err);
        res.status(500).json({ error: 'An error occurred while getting a database connection' });
        return;
      }
  
      let query = 'DELETE FROM review WHERE Idusers = ? AND ISBN = ?';
  
      connection.query(query, [userId, isbn], (err, results) => {
        if (err) {
          console.error('Error executing query:', err);
          res.status(500).json({ error: 'An error occurred while executing the query' });
          return;
        }
  
        // Check if any rows were affected by the delete operation
        if (results.affectedRows > 0) {
          res.sendStatus(200); // Send a success status code
        } else {
          res.sendStatus(404); // Send a not found status code if the review was not found
        }
  
        connection.release();
      });
    });
  });






module.exports = router;
