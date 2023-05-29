const express = require('express');
const router = express.Router();
const pool = require('../connect');


router.get('/:id', function (req, res) {
    const schoolId = req.params.id;
    // ... Update logic
  
    pool.getConnection(function (err, connection) {
      if (err) {
        console.error('Error getting database connection:', err);
        res.status(500).json({ error: 'An error occurred while getting a database connection' });
        return;
      }
  
      const query = `
      DELETE FROM SchoolUnit WHERE idSchool = ?

      `;
    
      connection.query(query, [ schoolId], (error, results) => {
        if (error) {
          console.error('Error updating school unit:', error);
          res.status(500).json({ error: 'An error occurred while updating the school unit' });
        } else {
          // Check if any rows were affected by the update query
          if (results.affectedRows > 0) {
            res.status(200).json({ message: 'School unit updated successfully' });
          } else {
            res.status(404).json({ error: 'School unit not found' });
          }
        }
        connection.release();
      });
    });
  });
  

module.exports = router;