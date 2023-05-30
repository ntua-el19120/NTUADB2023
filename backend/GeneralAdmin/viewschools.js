const express = require('express');
const router = express.Router();
const pool = require('../connect');

// Route to fetch all school units
router.get('/', function (req, res) {
  const query = 'SELECT * FROM SchoolUnit';

  pool.getConnection(function (err, connection) {
    if (err) {
      console.error('Error getting database connection:', err);
      res.status(500).json({ error: 'An error occurred while getting a database connection' });
      return;
    }

    // Execute the query to fetch all school units
    connection.query(query, (err, results) => {
      connection.release(); // Release the database connection

      if (err) {
        console.error('Error executing the query: ', err);
        res.status(500).send('Internal Server Error');
        return;
      }

      const schoolsHtml = generateSchoolsHtml(results);
      const html = `
        <!DOCTYPE html>
        <html>
        <head>
            <title>School Units</title>
            <style>
                table {
                    border-collapse: collapse;
                    width: 100%;
                }
                
                th, td {
                    padding: 8px;
                    text-align: left;
                }
                
                th {
                    background-color: #f2f2f2;
                }
            </style>
            <script>
                // JavaScript function to delete a school unit
                function deleteSchool(schoolId) {
                  if (confirm('Are you sure you want to delete this school unit?')) {
                    fetch('/libq/generaladmin/viewschools/delete', {
                      method: 'POST',
                      headers: {
                        'Content-Type': 'application/json'
                      },
                      body: JSON.stringify({ schoolId })
                    })
                      .then(response => {
                        if (response.ok) {
                          location.reload(); // Reload the page after successful deletion
                        } else {
                          console.error('Error deleting school unit:', response.statusText);
                          alert('An error occurred while deleting the school unit');
                        }
                      })
                      .catch(error => {
                        console.error('Error deleting school unit:', error);
                        alert('An error occurred while deleting the school unit');
                      });
                  }
                }
            </script>
        </head>
        <body>
            <h1>School Units</h1>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Address street</th>
                    <th>Address Number</th>
                    <th>City</th>
                    <th>Email</th>
                    <th>School Principle</th>
                    <th>School Admin</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
                ${schoolsHtml}
            </table>
            <ul style="list-style-type: none; font-size: 16px; margin-top: 20px;">
    <li style="margin-bottom: 10px;"><h3><a href="http://localhost:9103/libq/generaladmin/createschool">Create a new schoolUnit</a></h3></li>
    <li style="margin-bottom: 10px;"><h3><a href="http://localhost:9103/libq/generaladmin">Back to the homepage</a></h3></li>
</ul>

        </body>
        </html>
      `;

      res.send(html);
    });
  });
});

function generateSchoolsHtml(schools) {
  let html = '';

  schools.forEach((school) => {
    html += '<tr>';
    html += `<td>${school.IdSchool}</td>`;
    html += `<td>${school.Name}</td>`;
    html += `<td>${school.Adress_street}</td>`;
    html += `<td>${school.Adress_number}</td>`;
    html += `<td>${school.Adress_city}</td>`;
    html += `<td>${school.Email}</td>`;
    html += `<td>${school.SchoolPrinciple}</td>`;
    html += `<td>${school.SchoolAdmin}</td>`;
    html += `<td><a href="/libq/generaladmin/updateschool/${school.IdSchool}">Edit</a></td>`; // Add Edit link
    html += `<td><button onclick="deleteSchool(${school.IdSchool})">Delete</button></td>`; // Add Delete button
    html += '</tr>';
  });

  return html;
}

// Route for deleting a school
router.post('/delete', function (req, res) {
  const { schoolId } = req.body;

  const deleteQuery = 'DELETE FROM SchoolUnit WHERE IdSchool = ?';
  pool.getConnection(function (err, connection) {
    if (err) {
      console.error('Error getting database connection:', err);
      res.status(500).json({ error: 'An error occurred while getting a database connection' });
      return;
    }

    // Execute the delete query
    connection.query(deleteQuery, [schoolId], (err, results) => {
      connection.release(); // Release the database connection

      if (err) {
        console.error('Error executing the delete query:', err);
        res.status(500).json({ error: 'An error occurred while deleting the school' });
        return;
      }

      res.sendStatus(200); // Send a success response
    });
  });
});

module.exports = router;
