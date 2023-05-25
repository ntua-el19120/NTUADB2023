
// Require the necessary modules at the top of your file:
const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');


// Set up the MySQL connection:
const connection = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',
  password: '',
  database: 'bookies'
});

connection.connect((err) => {
  if (err) throw err;
  console.log('Connected to the MySQL database');
});

// Set up the Express server:
const app = express();
const port = 3000; // Change the port number if needed

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});

app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html');
  });
  


app.get('/books', (req, res) => {
    const { title, publisher, rating } = req.query;
  
    let conditions = [];
    let values = [];
  
    if (title) {
      conditions.push('Title = ?');
      values.push(title);
    }
    if (publisher) {
      conditions.push('Publisher = ?');
      values.push(publisher);
    }
    if (rating) {
      conditions.push('Rating = ?');
      values.push(rating);
    }
  
    let query = 'SELECT * FROM Book';
  
    if (conditions.length > 0) {
      const whereClause = conditions.join(' AND ');
      query += ' WHERE ' + whereClause;
    }
  
    connection.query(query, values, (err, results) => {
        if (err) throw err;
        res.json(results);
      });


  });
  