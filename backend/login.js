const express = require('express');
const router = express.Router();
const pool = require('./connect');



// Handle the login form submission
// ...

router.post('/', function (req, res) {
  const { username } = req.body;
  pool.getConnection(function (err, connection) {
    if (err) {
      res.status(500).json({ status: 'failed', reason: 'connection to database not established.' });
      console.log(err);
    } else {
      connection.query('SELECT * FROM users WHERE IDusers = ?', [username], (err, results) => {
        if (err) {
          console.error('Error querying MySQL:', err);
          return;
        }

        if (results.length > 0) {
          connection.query('DELETE FROM Loggeduser;');
          connection.query('INSERT INTO Loggeduser(IdLogged) VALUES (?)', [username], (err, results) => {
            if (err) {
              console.error('Error querying MySQL:', err);
              return;
            }

            // Check the role of the user and redirect accordingly
            connection.query('SELECT * FROM generaladmin WHERE IDusers = ?', [username], (err, results) => {
              if (err) {
                console.error('Error querying MySQL:', err);
                return;
              }
              if (results.length > 0) {
                res.redirect('/GeneralAdmin');
              } else {
                connection.query('SELECT * FROM schooladmin WHERE IDusers = ?', [username], (err, results) => {
                  if (err) {
                    console.error('Error querying MySQL:', err);
                    return;
                  }
                  if (results.length > 0) {
                    res.redirect('/SchoolAdmin');
                  } else {
                    res.redirect('/user');
                  }
                });
              }
            });
          });
        }
      });
    }

    connection.release();
  });
});

// ...


module.exports = router;
