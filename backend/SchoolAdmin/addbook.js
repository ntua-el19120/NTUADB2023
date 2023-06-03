const express = require('express');
const router = express.Router();
const pool = require('../connect');


  
   router.post('/:ISBN', function (req, res) {

      
       let ISBN = req.params.ISBN;
  
       const { Copies } = req.body;
    
       pool.getConnection(function (err, connection) {
         if (err) {
           console.error('Error getting database connection:', err);
           res.status(500).json({ error: 'An error occurred while getting a database connection' });
           return;
         }
    
         let query = 'SELECT s.idSchool as idSchool FROM schooladmin s, loggeduser l WHERE s.idusers=l.idlogged';
    
         connection.query(query, (error, results) => {
           if (error) {
             console.error('Error retrieving school unit:', error);
             res.status(500).json({ error: 'An error occurred while retrieving the school unit' });
             return;
           }
    
           const School = results[0].idSchool; // Assign the retrieved school ID to the School variable
    
           const updateBookQuery = `
           INSERT INTO Availability 
           (Copies, AvailableCopies, IdSchool, ISBN)
           VALUES (?, ?, ?, ?)
         `;
             
          connection.query(
            updateBookQuery,
            [Copies, Copies, School, ISBN],
            (error, bookUpdateResults) => {
              if (error) {
                console.error('Error updating book:', error);
                res.status(500).json({ error: 'An error occurred while updating the book' });
                return;
              }
                     
                      if (
                        bookUpdateResults.affectedRows > 0
                      ) {
                        res.redirect('/libq/schooladmin/viewbooks1');
                      } else {
                        res.status(404).json({ error: 'Book not found' });
                      }
                    }
                  );
                }
              );
            }
          );
        });
  












// Handle the create book form submission
// router.post('/', function (req, res) {
//   const { ISBN, Title, Publisher, PageNumber, Summary, Picture, Language } = req.body;

//   pool.getConnection(function (err, connection) {
//     if (err) {
//       console.error('Error getting database connection:', err);
//       res.status(500).json({ error: 'An error occurred while getting a database connection' });
//       return;
//     }

//     // const query00 = "select * from book where ISBN=?"
    
//     // connection.query(query, [ISBN, Title, Publisher, PageNumber, Summary, Picture, Language], (error, results) => {
//     //     if (error) {
//     //       console.error('Error creating book:', error);
//     //       res.status(500).json({ error: 'Failed to create book' });
//     //       return;
//     //     }


//     const query = 'INSERT INTO Book (ISBN, Title, Publisher, PageNumber, Summary, Picture, Language) VALUES (?, ?, ?, ?, ?, ?, ?)';

//     connection.query(query, [ISBN, Title, Publisher, PageNumber, Summary, Picture, Language], (error, results) => {
//       if (error) {
//         console.error('Error creating book:', error);
//         res.status(500).json({ error: 'Failed to create book' });
//         return;
//       }

//       // Get the newly created book ID
//       const bookId = results.insertId;

//       const query2 = 'SELECT s.idSchool as idSchool FROM schooladmin s, loggeduser l WHERE s.idusers=l.idlogged';

//       connection.query(query2, (error, results) => {
//         if (error) {
//           console.error('Error retrieving school unit:', error);
//           res.status(500).json({ error: 'An error occurred while retrieving the school unit' });
//           return;
//         }

//         const School = results[0].idSchool; // Assign the retrieved school ID to the School variable

//         const query3 = 'INSERT INTO Availability (Copies, AvailableCopies, IdSchool, ISBN) VALUES (?, ?, ?, ?)';

//         connection.query(query3, [0, 0, School, ISBN], (error, results) => {
//           if (error) {
//             console.error('Error creating availability:', error);
//             res.status(500).json({ error: 'Failed to create availability' });
//             return;
//           }

//           // Redirect the user to /libq/generaladmin/viewschools
//           res.status(200).redirect('/libq/generaladmin/viewbooks1');
//         });
//       });
//     });
//   });
// });

module.exports = router;
