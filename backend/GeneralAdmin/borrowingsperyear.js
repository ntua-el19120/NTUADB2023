const express = require('express');
const router = express.Router();
const pool = require('../connect');

router.get('/', function (req, res) {
  const { Category } = req.query;

  pool.getConnection(function (err, connection) {
    if (err) {
      console.error('Error getting database connection:', err);
      res.status(500).json({ error: 'An error occurred while getting a database connection' });
      return;
    }

  const query = `
  SELECT NumBorrowedBooks, GROUP_CONCAT(DISTINCT SchoolAdminName) AS SchoolAdminList
  FROM (
      SELECT YEAR(b.BorrowDate) AS Year, p.SchoolAdminName, COUNT(b.ISBN) AS NumBorrowedBooks
      FROM Persons_Per_School_View p
      JOIN Borrowing b ON p.PersonId = b.IdUsers
      GROUP BY YEAR(b.BorrowDate), p.SchoolAdminName
  ) AS subquery
  WHERE NumBorrowedBooks > 20
  GROUP BY NumBorrowedBooks
  ORDER BY NumBorrowedBooks DESC;
`;

    connection.query(query, (err, results) => {
      if (err) {
        console.error('Error executing query:', err);
        res.status(500).json({ error: 'An error occurred while executing the query' });
        return;
      }

  // Generate HTML table
  let htmlTable = `
    <!DOCTYPE html>
    <html>
    <head>
      <title>Query 3.1.5</title>
      <style>
        /* CSS for the table and scrolling */
        #results-table {
          width: 100%;
          border-collapse: collapse;
          table-layout: fixed;
        }
      
        #results-table th,
        #results-table td {
          padding: 8px;
          border: 1px solid #ddd;
        }
      
        #results-container {
          max-height: 300px;
          overflow-y: scroll;
        }
      </style>
    </head>
    <body>
      <h1>How many books the SchoolAdmins Gave in 1 Year</h1>
      <div id="results-container">
        <table id="results-table">
          <thead>
            <tr>
              <th>Number of Borrowed Books</th>
              <th>List of school Admins</th>

            </tr>
          </thead>
          <tbody>
  `;

  // Append rows to the HTML table
  for (const row of results) {
    htmlTable += `
      <tr>
        <td>${row.NumBorrowedBooks}</td>
        <td>${row.SchoolAdminList}</td>
      </tr>
    `;
  }

      // Send the HTML response
      res.send(htmlTable);

      connection.release();
    });
  });
});

module.exports = router;






// pool.getConnection(function (err, connection) {
//   if (err) {
//     console.error('Error getting database connection:', err);
//     res.status(500).json({ error: 'An error occurred while getting a database connection' });
//     return;
//   }

//   const query = `
//   SELECT NumBorrowedBooks, GROUP_CONCAT(DISTINCT SchoolAdminName) AS SchoolAdminList
//   FROM (
//       SELECT YEAR(b.BorrowDate) AS Year, p.SchoolAdminName, COUNT(b.ISBN) AS NumBorrowedBooks
//       FROM Persons_Per_School_View p
//       JOIN Borrowing b ON p.PersonId = b.IdUsers
//       GROUP BY YEAR(b.BorrowDate), p.SchoolAdminName
//   ) AS subquery
//   WHERE NumBorrowedBooks > 20
//   GROUP BY NumBorrowedBooks
//   ORDER BY NumBorrowedBooks DESC;
// `;    

// connection.query(query, (err, results) => {
//   if (err) {
//     console.error('Error executing query:', err);
//     res.status(500).json({ error: 'An error occurred while executing the query' });
//     return;
//   }

//   // Generate HTML table
//   let htmlTable = `
//     <!DOCTYPE html>
//     <html>
//     <head>
//       <title>Query 3.1.5</title>
//       <style>
//         /* CSS for the table and scrolling */
//         #results-table {
//           width: 100%;
//           border-collapse: collapse;
//           table-layout: fixed;
//         }
      
//         #results-table th,
//         #results-table td {
//           padding: 8px;
//           border: 1px solid #ddd;
//         }
      
//         #results-container {
//           max-height: 300px;
//           overflow-y: scroll;
//         }
//       </style>
//     </head>
//     <body>
//       <h1>How many books the SchoolAdmins Gave in 1 Year</h1>
//       <div id="results-container">
//         <table id="results-table">
//           <thead>
//             <tr>
//               <th>Number of Borrowed Books</th>
//               <th>List of school Admins</th>

//             </tr>
//           </thead>
//           <tbody>
//   `;

//   // Append rows to the HTML table
//   for (const row of results) {
//     htmlTable += `
//       <tr>
//         <td>${row.NumBorrowedBooks}</td>
//         <td>${row.SchoolAdminList}</td>
//       </tr>
//     `;
//   }

//   // Complete the HTML table
//   htmlTable += `
//           </tbody>
//         </table>
//       </div>
//     </body>
//     </html>
//   `;

//   // Send the HTML response
//   res.send(htmlTable);

//   connection.release();
// });