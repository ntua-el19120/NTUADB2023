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

    const query = 'SELECT DISTINCT * FROM SchoolAdminsApplications  ';

    connection.query(query, (err, results) => {
      if (err) {
        console.error('Error executing query:', err);
        res.status(500).json({ error: 'An error occurred while executing the query' });
        return;
      }

      let tableHtml = `
      <table>
        <tr>
          <th>Name</th>
          <th>Action</th>
        </tr>
    `;

    results.forEach(admin => {
      tableHtml += `
        <tr>
          <td>${admin.name}</td>
          <td>
            <form action="/libq/generaladmin/SaApplications/approve" method="POST">
              <input type="hidden" name="adminId" value="${admin.name}">
              <button type="submit">Approve</button>
            </form>
          </td>
        </tr>
      `;
    });

    tableHtml += '</table>';

    // Send the generated HTML table as the response
    res.send(tableHtml);

      connection.release();
    });
  });
});

module.exports = router;


router.post('/approve', (req, res) => {
    const adminname = req.body.adminId;


    pool.getConnection(function (err, connection) {
        if (err) {
          console.error('Error getting database connection:', err);
          res.status(500).json({ error: 'An error occurred while getting a database connection' });
          return;
        }
  
    // Update the 'Approved' field in the Users table to 1
    const updateQuery = 'UPDATE users SET Approved = 1 WHERE IdUsers = ( SELECT IdUsers FROM schooladmin WHERE name = ?)';
  
    // Execute the update query
    connection.query(updateQuery, [adminname], (err, results) => {
      if (err) throw err;
      console.log(`Admin with Name ${adminname} approved`);

        connection.release();

      // Redirect back to the homepage after approval
      res.redirect('/libq/generaladmin/SaApplications');
    
    });
    
  });
});

module.exports = router;
