const express = require('express');
const router = express.Router();
const pool = require('../connect');

router.get('/pika/:idlogged/:ISBN', function (req, res) {
  const userId = req.params.idlogged;
  const isbn = req.params.ISBN;

  pool.getConnection(function (err, connection) {
    if (err) {
      console.error('Error getting database connection:', err);
      res.status(500).json({ error: 'An error occurred while getting a database connection' });
      return;
    }

    const query = `
      SELECT * FROM review
      WHERE IdUsers = ? AND ISBN = ?
    `;

    connection.query(query, [userId, isbn], (error, results) => {
      if (error) {
        console.error('Error retrieving review:', error);
        res.status(500).json({ error: 'An error occurred while retrieving the review' });
      } else {
        if (results.length > 0) {
          const review = results[0];
          res.json({ review }); // Send the review data as JSON response
        } else {
          res.status(404).json({ error: 'Review not found' });
        }
      }
      connection.release();
    });
  });
});

router.post('/:idlogged/:ISBN', function (req, res) {
  const userId = req.params.idlogged;
  const isbn = req.params.ISBN;

  const { ReviewText, RatingLikert } = req.body;

  pool.getConnection(function (err, connection) {
    if (err) {
      console.error('Error getting database connection:', err);
      res.status(500).json({ error: 'An error occurred while getting a database connection' });
      return;
    }

    const checkQuery = `
      SELECT * FROM review
      WHERE IdUsers = ? AND ISBN = ?
    `;

    connection.query(checkQuery, [userId, isbn], (error, results) => {
      if (error) {
        console.error('Error checking review:', error);
        res.status(500).json({ error: 'An error occurred while checking the review' });
      } else {
        if (results.length > 0) {
          // Review already exists, update the existing row
          const updateQuery = `
            UPDATE review
            SET ReviewText = ?, RatingLikert = ?, Approval = 0
            WHERE IdUsers = ? AND ISBN = ?
          `;

          connection.query(
            updateQuery,
            [ReviewText, RatingLikert, userId, isbn],
            (error, results) => {
              if (error) {
                console.error('Error updating review:', error);
                res.status(500).json({ error: 'An error occurred while updating the review' });
              } else {
                // Check if any rows were affected by the update query
                if (results.affectedRows > 0) {
                  const goBackURL = '/libq/user/myborrowings'; // Specify the URL to go back to
                  const message = 'Review updated successfully';

                  // Generate HTML response with the "Go Back" button and the message
                  const htmlResponse = `
                    <!DOCTYPE html>
                    <html>
                      <head>
                        <title>Review Updated</title>
                      </head>
                      <body>
                        <h1>${message}</h1>
                        <button onclick="location.href='${goBackURL}'">Go Back</button>
                      </body>
                    </html>
                  `;

                  // Send the HTML response
                  res.send(htmlResponse);
                } else {
                  res.status(404).json({ error: 'Review not found' });
                }
              }
              connection.release();
            }
          );
        } else {
          // Review doesn't exist, create a new row
          const insertQuery = `
            INSERT INTO review (IdUsers, ISBN, ReviewText, RatingLikert, Approval)
            VALUES (?, ?, ?, ?, 0)
          `;

          connection.query(
            insertQuery,
            [userId, isbn, ReviewText, RatingLikert],
            (error, results) => {
              if (error) {
                console.error('Error creating review:', error);
                res.status(500).json({ error: 'An error occurred while creating the review' });
              } else {
                const goBackURL = '/libq/user/myborrowings'; // Specify the URL to go back to
                const message = 'Review created successfully';

                // Generate HTML response with the "Go Back" button and the message
                const htmlResponse = `
                  <!DOCTYPE html>
                  <html>
                    <head>
                      <title>Review Created</title>
                    </head>
                    <body>
                      <h1>${message}</h1>
                      <button onclick="location.href='${goBackURL}'">Go Back</button>
                    </body>
                  </html>
                `;

                // Send the HTML response
                res.send(htmlResponse);
              }
              connection.release();
            }
          );
        }
      }
    });
  });
});


module.exports = router;
