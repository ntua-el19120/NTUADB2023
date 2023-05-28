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

app.get('/libq/generaladmin/createschool', function (req, res) {
  res.sendFile(path.join(__dirname, '../frontend/createschool.html'));
});

app.get('/libq/generaladmin/updateschool/:id', function (req, res) {
  const schoolId = req.params.id;
  res.sendFile(path.join(__dirname, '../frontend/updateschool.html'));
});




// Serve the login page
const login = require('./login');
app.use('/libq/login', login);

const backupRouter = require('./GeneralAdmin/backup.js');
app.use('/libq/backup', backupRouter);

const viewSchools = require('./GeneralAdmin/viewschools.js');
app.use('/libq/generaladmin/viewschools', viewSchools);

const deleteSchool = require('./GeneralAdmin/deleteschools.js');
app.use('/libq/generaladmin/deleteschool', deleteSchool);



const createSchool = require('./GeneralAdmin/createschool.js');
app.use('/libq/generaladmin/createdschool', createSchool);


const RestoreRouter = require('./GeneralAdmin/restore.js');
app.use('/libq/restore', RestoreRouter);

const updateSchool = require('./GeneralAdmin/updateschool.js');
app.use('/libq/generaladmin/updateschool', updateSchool);



app.listen(PORT, () => {
  console.log(`App listening at: http://localhost:${PORT}${baseurl}`);
});
