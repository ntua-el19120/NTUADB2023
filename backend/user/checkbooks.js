const express = require('express');
const router = express.Router();
const pool = require('../connect');

router.get('/', function (req, res) {
  const { Category, Title, Publisher } = req.query;

  let conditions = [];
  let values = [];

  if (Title) {
    conditions.push('Title = ?');
    values.push(Title);
  }

  if (Category) {
    conditions.push('Category = ?');
    values.push(Category);
  }

  if (Publisher) {
    conditions.push('Publisher = ?');
    values.push(Publisher);
  }

  pool.getConnection(function (err, connection) {
    if (err) {
      console.error('Error getting database connection:', err);
      res.status(500).json({ error: 'An error occurred while getting a database connection' });
      return;
    }

  
    // SELECT persons_per_school_view.IdSchool
    // FROM persons_per_school_view
    // JOIN LoggedUSer ON persons_per_school_view.PersonId = LoggedUSer.IdLogged;
    //        SELECT DISTINCT
    //       ISBN,
    //       Title,
    //       Publisher,
    //       PageNumber,
    //       Summary,
    //       Picture,
    //       Language,
    //       Rating,
    //       AvailableCopies,
    //       Categories
    //     FROM
    //       book_combined_view
    //     WHERE
    //       IdSchool = 4


    let query0='DROP VIEW IF EXISTS Persons_Per_School_View'
    connection.query(query0, (err, results) => {
      if (err) {
        console.error('Error executing query:', err);
        res.status(500).json({ error: 'An error occurred while executing the query' });
        return;
      }

      let query01=`CREATE VIEW Persons_Per_School_View AS
       SELECT sa.IdUsers as IdSchoolAdmin, sa.Name as SchoolAdminName, s.IdSchool, 'Student' AS PersonType, st.IdUsers AS PersonId, st.StudentName AS PersonName, st.StudentEmail AS PersonEmail
       FROM Student st
       JOIN SchoolAdmin sa ON st.IdSchool = sa.IdSchool
       JOIN SchoolUnit s ON sa.IdSchool = s.IdSchool
       UNION ALL
       SELECT sa.IdUsers IdSchoolAdmin, sa.Name as SchoolAdminName ,s.IdSchool, 'Teacher' AS PersonType, t.IdUsers AS PersonId, t.TeacherName AS PersonName, t.TeacherEmail AS PersonEmail
       FROM Teacher t
       JOIN SchoolAdmin sa ON t.IdSchool = sa.IdSchool
       JOIN SchoolUnit s ON sa.IdSchool = s.IdSchool; `

       connection.query(query01, (err, results) => {
        if (err) {
          console.error('Error executing query:', err);
          res.status(500).json({ error: 'An error occurred while executing the query' });
          return;
        }
  

    let query1 = `
    SELECT persons_per_school_view.IdSchool
    FROM persons_per_school_view
    JOIN LoggedUSer ON persons_per_school_view.PersonId = LoggedUSer.IdLogged;
    `;

    connection.query(query1, (err, results) => {
      if (err) {
        console.error('Error executing query:', err);
        res.status(500).json({ error: 'An error occurred while executing the query' });
        return;
      }

      // Assuming the query returns a single row with the `IdSchool` column
      const idSchool = results[0].IdSchool;

      let query = `
        SELECT DISTINCT
          ISBN,
          Title,
          Publisher,
          PageNumber,
          Summary,
          Picture,
          Language,
          Rating,
          AvailableCopies,
          Categories
        FROM
          book_combined_view
        WHERE
          IdSchool = ?`;

      if (conditions.length > 0) {
        const whereClause = conditions.join(' AND ');
        query += ' AND ' + whereClause + ' ORDER BY Title';
      }

      connection.query(query, [idSchool, ...values], (err, results) => {
        if (err) {
          console.error('Error executing query:', err);
          res.status(500).json({ error: 'An error occurred while executing the query' });
          return;
        }
        res.json(results);
      });
    });

    connection.release();
  });
});
  });
});

module.exports = router;
