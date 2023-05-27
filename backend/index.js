const express = require('express');
const app = express();
const PORT = 9103;
const baseurl = '/libq';
const path = require('path');
const { exec } = require('child_process');

// Middleware to parse request body
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

// Serve the login page
app.get('/libq', function (req, res) {
  res.sendFile(path.join(__dirname, '../frontend/login.html'));
});

// Serve the login page
const login = require('./login');
app.use('/libq/login', login);

const backupRouter = require('./GeneralAdmin/backup.js');
app.use('/libq/backup', backupRouter);


const RestoreRouter = require('./GeneralAdmin/restore.js');
app.use('/libq/restore', RestoreRouter);


app.listen(PORT, () => {
  console.log(`App listening at: http://localhost:${PORT}${baseurl}`);
});
