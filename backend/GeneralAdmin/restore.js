const express = require('express');
const router = express.Router();
const path = require('path');
const fs = require('fs');
const { exec } = require('child_process');
const mysql = require('../node_modules/mysql');

// Define routes for backup-related functionality
router.get('/', (req, res) => {

    const backupFilePath = './backup/backup.sql'; // Location of the backup file for restoration
      
        // Read the SQL statements from the backup file
        fs.readFile(backupFilePath, 'utf8', (err, data) => {
          if (err) {
            console.error('Error reading the backup file:', err);
            res.status(500).send('Error reading the backup file');
            return;
          }
      
          const sqlStatements = data.trim().split(';'); // Split the file content into individual SQL statements
      
          // Create a new database connection
          const connection = mysql.createConnection({
            host: '127.0.0.1',
            user: 'root',
            password: '',
            database: 'libq'
          });
      
          connection.connect((err) => {
            if (err) {
              console.error('Error connecting to the database:', err);
              res.status(500).send('Error connecting to the database');
              return;
            }
      
            // Execute each SQL statement sequentially
            sqlStatements.forEach((statement) => {
              connection.query(statement, (error) => {
                if (error) {
                  console.error('Error executing SQL statement:', error);
                  res.status(500).send('Error during restoration from backup');
                  connection.end();
                  return;
                }
              });
            });
      
            connection.end();
            console.log('Restoration from backup completed successfully');
            res.status(200).send('Restoration from backup completed successfully');
          });
        });
      });

// Export the router instance
module.exports = router;
