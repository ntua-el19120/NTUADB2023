const express = require('express');
const router = express.Router();
const pool = require('../connect');

// Handle the login form submission
// ...

router.post('/', function (req, res) {
  const { Name, Adress_street, Adress_number, Adress_city, Email, SchoolPrinciple, SchoolAdmin } = req.body;

  pool.getConnection(function (err, connection) {
    if (err) {
      console.error('Error getting database connection:', err);
      res.status(500).json({ error: 'An error occurred while getting a database connection' });
      return;
    }

    const query = `
      INSERT INTO SchoolUnit (Name, Adress_street, Adress_number, Adress_city, Email, SchoolPrinciple, SchoolAdmin)
      VALUES (?, ?, ?, ?, ?, ?, ?)
    `;

    connection.query(query, [Name, Adress_street, Adress_number, Adress_city, Email, SchoolPrinciple, SchoolAdmin], (error, results) => {
      connection.release();

      if (error) {
        console.error('Error creating school unit:', error);
        res.status(500).json({ error: 'An error occurred while creating the school unit' });
        return;
      }

      // Redirect the user to /libq/generaladmin/viewschools
      res.redirect('/libq/generaladmin/viewschools');
    });
  });
});

module.exports = router;
