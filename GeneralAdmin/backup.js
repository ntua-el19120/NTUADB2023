const express = require('express');
const router = express.Router();
const path = require('path');
const fs = require('fs');
const { exec } = require('child_process');
const mysql = require('../node_modules/mysql');

// Define routes for backup-related functionality
router.get('/', (req, res) => {
  const backupFileName = 'backup.sql';
  const backupFilePath = path.join('./backup/', backupFileName);

  // Check if the backup file already exists and delete it
  if (fs.existsSync(backupFilePath)) {
    fs.unlinkSync(backupFilePath);
  }

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

    // Retrieve the list of tables in the database
    connection.query("SHOW TABLES", (error, results) => {
      if (error) {
        console.error('Error retrieving table list:', error);
        res.status(500).send('Error retrieving table list');
        connection.end();
        return;
      }

      const tables = results.map((row) => row[`Tables_in_${connection.config.database}`]);

      if (tables.length === 0) {
        console.log('The database does not contain any tables.');
        res.status(200).send('The database does not contain any tables.');
        connection.end();
        return;
      }

      // Generate the SQL statements to export each table
      let sqlStatements = '';

      tables.forEach((table, index) => {
        connection.query(`DESCRIBE ${table}`, (error, fields) => {
          if (error) {
            console.error(`Error retrieving column names for table ${table}:`, error);
            res.status(500).send(`Error retrieving column names for table ${table}`);
            return;
          }

          const columnNames = fields.map(field => `\`${field.Field}\``);

          connection.query(`SELECT * FROM ${table}`, (error, results) => {
            if (error) {
              console.error(`Error retrieving data from table ${table}:`, error);
              res.status(500).send(`Error retrieving data from table ${table}`);
              return;
            }

            const tableData = results.map(row => {
              const values = columnNames.map(column => {
                const value = row[column.replace(/`/g, '')];
                return typeof value === 'string' ? `'${value}'` : value;
              });
              return `(${values.join(', ')})`;
            });

            sqlStatements += `INSERT INTO \`${table}\` (${columnNames.join(', ')}) VALUES ${tableData.join(', ')};\n`;

            if (index === tables.length - 1) {
              // Last table, write the SQL statements to the backup file
              fs.writeFile(backupFilePath, sqlStatements, err => {
                connection.end();

                if (err) {
                  console.error('Error creating the backup:', err);
                  res.status(500).send('Error creating the backup');
                } else {
                  console.log(`Backup created successfully: ${backupFilePath}`);
                  res.status(200).send('Backup created successfully');
                }
              });
            }
          });
        });
      });
    });
  });
});

// Export the router instance
module.exports = router;
