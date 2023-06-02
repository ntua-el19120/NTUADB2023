const express = require('express');
const router = express.Router();
const pool = require('../connect');

router.get('/', function (req, res) {
  pool.getConnection((err, connection) => {
    if (err) {
      console.error('Error connecting to database:', err);
      res.status(500).send('Internal Server Error');
      return;
    }

    const loggedUserQuery = `
      SELECT IdLogged
      FROM LoggedUser
      ORDER BY IdLogged DESC
      LIMIT 1;
    `;

    connection.query(loggedUserQuery, (error, loggedUserResults) => {
      if (error) {
        console.error('Error executing query:', error);
        res.status(500).send('Internal Server Error');
        return;
      }

      const userId = loggedUserResults[0].IdLogged;

      const query = `
        SELECT b.*,
          GROUP_CONCAT(DISTINCT bc.Category SEPARATOR ', ') AS Categories,
          GROUP_CONCAT(DISTINCT bk.Keyword SEPARATOR ', ') AS Keywords
        FROM book AS b
        JOIN availability AS a ON b.ISBN = a.ISBN
        LEFT JOIN book_categories AS bc ON b.ISBN = bc.ISBN
        LEFT JOIN book_keywords AS bk ON b.ISBN = bk.ISBN
        WHERE EXISTS (
          SELECT 1
          FROM student AS s
          WHERE s.IdUsers = ${userId} AND a.IdSchool = s.IdSchool
        )
        OR EXISTS (
          SELECT 1
          FROM teacher AS t
          WHERE t.IdUsers = ${userId} AND a.IdSchool = t.IdSchool
        )
        GROUP BY b.ISBN;
      `;

      connection.query(query, (error, results) => {
        connection.release(); // Release the connection

        if (error) {
          console.error('Error executing query:', error);
          res.status(500).send('Internal Server Error');
          return;
        }

        const tableRows = results
          .map(
            (book) => `
              <tr>
                <td>${book.ISBN}</td>
                <td>${book.Title}</td>
                <td>${book.Publisher}</td>
                <td>${book.PageNumber}</td>
                <td>${book.Summary}</td>
                <td><img src="${book.Picture}" alt="Book Cover" height="300"></td>
                <td>${book.Language}</td>
                <td>${book.Rating}</td>
                <td>${book.Categories}</td>
                <td>${book.Keywords}</td>
              </tr>
            `
          )
          .join('');

        const html = `
          <html>
            <head>
              <meta charset="utf-8">
              <title>Late Users</title>
              <style>
                body {
                  font-family: Arial, sans-serif;
                  background-color: #f4f4f4;
                }

                h1, h2 {
                  text-align: center;
                  color: #333;
                }

                .container {
                  max-width: 800px;
                  margin: 0 auto;
                  padding: 20px;
                }

                .search-container {
                  display: flex;
                  justify-content: space-between;
                  align-items: center;
                  margin-bottom: 20px;
                }

                .search-container label {
                  font-weight: bold;
                }

                .search-container input[type="text"] {
                  padding: 8px;
                  font-size: 14px;
                  border: 1px solid #ccc;
                  border-radius: 4px;
                  width: 200px;
                }

                table {
                  border-collapse: collapse;
                  width: 100%;
                  margin-bottom: 20px;
                }

                th, td {
                  border: 1px solid #ddd;
                  padding: 8px;
                  text-align: left;
                }

                th {
                  background-color: #808285;
                  color: #fff;
                }

                .back-button {
                  display: inline-block;
                  padding: 8px 16px;
                  font-size: 14px;
                  font-weight: bold;
                  text-decoration: none;
                  background-color: #4CAF50;
                  color: #fff;
                  border: none;
                  border-radius: 4px;
                }

                .back-button::before {
                  content: '←';
                  margin-right: 5px;
                }
              </style>
            </head>
            <body>
              <div class="container">
                <h1>Books</h1>
                <div class="search-container">
                  <label for="titleSearch">Search by Title:</label>
                  <input type="text" id="titleSearch" oninput="searchByTitle()">
                </div>
                <div class="search-container">
                  <label for="publisherSearch">Search by Publisher:</label>
                  <input type="text" id="publisherSearch" oninput="searchByPublisher()">
                </div>
                <div class="search-container">
                  <label for="categorySearch">Search by Category:</label>
                  <select id="categorySearch" onchange="searchByCategory()">
                    <option value="">Select Category</option>
                    <option value="Ιστορία (History)">Ιστορία (History)</option>
                    <option value="Μυθιστόρημα (Novel)">Μυθιστόρημα (Novel)</option>
                    <option value="Φαντασία (Fantasy)">Φαντασία (Fantasy)</option>
                    <option value="Μυστήριο (Mystery)">Μυστήριο (Mystery)</option>
                    <option value="Θρίλερ (Thriller)">Θρίλερ (Thriller)</option>
                    <option value="Ρομαντικό (Romance)">Ρομαντικό (Romance)</option>
                    <option value="Ποίηση (Poetry)">Ποίηση (Poetry)</option>
                    <option value="Διηγήματα (Short Stories)">Διηγήματα (Short Stories)</option>
                    <option value="Αυτοβελτίωση (Self-Improvement)">Αυτοβελτίωση (Self-Improvement)</option>
                    <option value="Θρησκεία (Religion)">Θρησκεία (Religion)</option>
                    <option value="Φιλοσοφία (Philosophy)">Φιλοσοφία (Philosophy)</option>
                    <option value="Ψυχολογία (Psychology)">Ψυχολογία (Psychology)</option>
                    <option value="Παιδικά βιβλία (Childrens Books)">Παιδικά βιβλία (Children's Books)</option>
                    <option value="Ταξίδια (Travel)">Ταξίδια (Travel)</option>
                    <option value="Τέχνη (Art)">Τέχνη (Art)</option>
                    <option value="Αρχιτεκτονική (Architecture)">Αρχιτεκτονική (Architecture)</option>
                    <option value="Μαγειρική (Cooking)">Μαγειρική (Cooking)</option>
                    <option value="Αθλητισμός (Sports)">Αθλητισμός (Sports)</option>
                    <option value="Επιστημονικά (Science)">Επιστημονικά (Science)</option>
                    <option value="Οικονομία (Economics)">Οικονομία (Economics)</option>
                    <option value="Πολιτική (Politics)">Πολιτική (Politics)</option>
                    <option value="Μαγικό Ρεαλισμό (Magical Realism)">Κοινωνιολογία (Sociology)</option>
                    <option value="Κοινωνιολογία (Sociology)">Κοινωνιολογία (Sociology)</option>
                    <option value="Διοίκηση (Management)">Διοίκηση (Management)</option>
                    <option value="Γλώσσες (Languages)">Γλώσσες (Languages)</option>
                    <option value="Μουσική (Music)">Μουσική (Music)</option>
                    <option value="Κινηματογράφος (Cinema)">Κινηματογράφος (Cinema)</option>
                    <option value="Διάφορα (Miscellaneous)">Διάφορα (Miscellaneous)</option>
                    <!-- Add more options for other categories -->
                  </select>
                </div>
                <table>
                  <thead>
                    <tr>
                      <th>ISBN</th>
                      <th>Title</th>
                      <th>Publisher</th>
                      <th>Page Number</th>
                      <th>Summary</th>
                      <th>Picture</th>
                      <th>Language</th>
                      <th>Rating</th>
                      <th>Categories</th>
                      <th>Keywords</th>
                    </tr>
                  </thead>
                  <tbody id="bookTableBody">
                    ${tableRows}
                  </tbody>
                </table>
                <a href="/libq/user" class="back-button">Back</a>
              </div>

              <script>
                function searchByTitle() {
                  const input = document.getElementById('titleSearch').value.toLowerCase();
                  const rows = document.querySelectorAll('#bookTableBody tr');

                  rows.forEach((row) => {
                    const title = row.querySelector('td:nth-child(2)').textContent.toLowerCase();
                    if (title.includes(input)) {
                      row.style.display = '';
                    } else {
                      row.style.display = 'none';
                    }
                  });
                }

                function searchByPublisher() {
                  const input = document.getElementById('publisherSearch').value.toLowerCase();
                  const rows = document.querySelectorAll('#bookTableBody tr');

                  rows.forEach((row) => {
                    const publisher = row.querySelector('td:nth-child(3)').textContent.toLowerCase();
                    if (publisher.includes(input)) {
                      row.style.display = '';
                    } else {
                      row.style.display = 'none';
                    }
                  });
                }

                function searchByCategory() {
                  const selectedCategory = document.getElementById('categorySearch').value.toLowerCase();
                  const rows = document.querySelectorAll('#bookTableBody tr');

                  rows.forEach((row) => {
                    const categories = row.querySelector('td:nth-child(9)').textContent.toLowerCase();
                    const categoryArray = categories.split(', ');

                    let found = categoryArray.some((category) => category.includes(selectedCategory));

                    if (found) {
                      row.style.display = '';
                    } else {
                      row.style.display = 'none';
                    }
                  });
                }

                document.getElementById('categorySearch').addEventListener('change', function() {
                  const selectedCategory = this.value;
                  if (selectedCategory === '') {
                    document.querySelectorAll('#bookTableBody tr').forEach((row) => {
                      row.style.display = '';
                    });
                  }
                });
              </script>
            </body>
          </html>
        `;

        res.send(html); // Send the HTML response
      });
    });
  });
});

module.exports = router;
