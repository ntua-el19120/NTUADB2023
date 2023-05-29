const express = require('express');
const router = express.Router();
const pool = require('../connect');
const fs = require('fs');
const path = require('path');

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
      if (err) {
        console.error('Error executing the query: ', err);
        res.status(500).send('Internal Server Error');
        return;
      }

      fs.readFile(path.join(__dirname, '../../frontend/viewschools.html'), 'utf8', (err, data) => {
        if (err) {
          console.error('Error reading the HTML template file:', err);
          res.status(500).send('Internal Server Error');
          return;
        }

        const schoolsHtml = generateSchoolsHtml(results);
        const renderedHtml = data.replace('<!-- schools_placeholder -->', schoolsHtml);
        res.send(renderedHtml);
      });
    });
  });
});

function generateSchoolsHtml(schools) {
  let html = '';

  schools.forEach((school) => {
    html += '<tr>';
    html += `<td>${school.IdSchool}</td>`;
    html += `<td>${school.Name}</td>`;
    html += `<td>${school.Address}</td>`;
    html += `<td>${school.City}</td>`;
    html += `<td>${school.Email}</td>`;
    html += `<td>${school.SchoolPrinciple}</td>`;
    html += `<td>${school.SchoolAdmin}</td>`;
    html += '</tr>';
  });

  return html;
}

module.exports = router;
