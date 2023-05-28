const express = require('express');
const router = express.Router();
const pool = require('../connect');

// Handle the login form submission
// ...

router.post('/', function (req, res) {
  const { Name, Address, City, Email, SchoolPrinciple, SchoolAdmin } = req.body;

  pool.getConnection(function (err, connection) {
    if (err) {
      console.error('Error getting database connection:', err);
      res.status(500).json({ error: 'An error occurred while getting a database connection' });
      return;
    }

    const query = `
      INSERT INTO SchoolUnit (Name, Address, City, Email, SchoolPrinciple, SchoolAdmin)
      VALUES (?, ?, ?, ?, ?, ?)
    `;

    connection.query(query, [Name, Address, City, Email, SchoolPrinciple, SchoolAdmin], (error, results) => {
      if (error) {
        console.error('Error creating school unit:', error);
        res.status(500).json({ error: 'An error occurred while creating the school unit' });
      } else {
        res.status(200).json({ message: 'School unit created successfully' });
      }
      
      connection.release();
    });
  });
});

module.exports = router;
