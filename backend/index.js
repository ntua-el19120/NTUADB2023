const express = require('express');
const app = express();
const PORT = 9103;
const baseurl = '/libq';
const path = require('path');
const mysql = require('mysql');


const { exec } = require('child_process');
const connection = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',
  password: '',
  database: 'libq'
});

// Connect to the MySQL server
connection.connect((err) => {
  if (err) throw err;
  console.log('Connected to MySQL server');
});

// Middleware to parse request body
app.use(express.json());
app.use(express.urlencoded({ extended: true }));


// Serve the login page
app.get('/libq/login', function (req, res) {
  res.sendFile(path.join(__dirname, '../frontend/login.html'));
});

app.get('/libq/signup', function (req, res) {
  res.sendFile(path.join(__dirname, '../frontend/signup.html'));
});

app.get('/libq/user/checkbooks1', (req, res) => {
  res.sendFile(path.join(__dirname, '../frontend/checkbooks.html'));
});

app.get('/libq/generaladmin', function (req, res) {
  res.sendFile(path.join(__dirname, '../frontend/GeneralAdmin.html'));
});

app.get('/libq/generaladmin/borrowings1', (req, res) => {
  res.sendFile(path.join(__dirname, '../frontend/Borrowrings.html'));
});

app.get('/libq/generaladmin/givenbookcategory1', (req, res) => {
  res.sendFile(path.join(__dirname, '../frontend/givenbookcategory.html'));
});


app.get('/libq/generaladmin/busywriters1', (req, res) => {
  res.sendFile(path.join(__dirname, '../frontend/busywriters.html'));
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

const signup = require('./signup');
app.use('/libq/signup', signup);

const backupRouter = require('./GeneralAdmin/backup.js');
app.use('/libq/backup', backupRouter);

const viewSchools = require('./GeneralAdmin/viewschools.js');
app.use('/libq/generaladmin/viewschools', viewSchools);


const createSchool = require('./GeneralAdmin/createschool.js');
app.use('/libq/generaladmin/createdschool', createSchool);

const schools = require('./schools.js'); 
app.use('/libq/schools', schools);

const RestoreRouter = require('./GeneralAdmin/restore.js');
app.use('/libq/restore', RestoreRouter);

const updateSchool = require('./GeneralAdmin/updateschool.js');
app.use('/libq/generaladmin/updateschool', updateSchool);


const Borrowrings = require('./GeneralAdmin/borrowings.js');
app.use('/libq/generaladmin/borrowings', Borrowrings);

const givenbookcategory = require('./GeneralAdmin/givenbookcategory.js');
app.use('/libq/generaladmin/givenbookcategory', givenbookcategory);

const unluckyWriters = require('./GeneralAdmin/unluckyWriters.js');
app.use('/libq/generaladmin/unluckywriters', unluckyWriters);

const youngteachers = require('./GeneralAdmin/youngteachers.js');
app.use('/libq/generaladmin/youngteachers', youngteachers);

const top3categories = require('./GeneralAdmin/top3categories.js');
app.use('/libq/generaladmin/top3categories', top3categories);

const busyWriters = require('./GeneralAdmin/busywriters.js');
app.use('/libq/generaladmin/busywriters', busyWriters);

const bpy = require('./GeneralAdmin/borrowingsperyear.js');
app.use('/libq/generaladmin/borrowingsperyear', bpy);



const SaApplication= require('./GeneralAdmin/SaApplications.js');
app.use('/libq/generaladmin/SaApplications', SaApplication);

const lateBorrowings = require('./SchoolAdmin/lateBorrowings.js');
app.use('/libq/schooladmin/lateborrowings', lateBorrowings);

const reviewAverages = require('./SchoolAdmin/ReviewAverages.js');
app.use('/libq/schooladmin/reviewaverages', reviewAverages);

const checkbooks = require('./user/checkbooks.js');
app.use('/libq/user/checkbooks', checkbooks);

const myBorrowings = require('./user/myborrowings.js');
app.use('/libq/user/myborrowings', myBorrowings);



app.listen(PORT, () => {
  console.log(`App listening at: http://localhost:${PORT}${baseurl}`);
});
