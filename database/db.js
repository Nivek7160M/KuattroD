const mysql = require('mysql2');
require('dotenv').config();

// Configuración de conexión
const connection = mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'test',
    port: process.env.DB_PORT || 3306
});

// Conectar a la base de datos
connection.connect(err => {
    if (err) {
        console.error('Error de conexión: ' + err.stack);
        return;
    }
    console.log('Conectado a la base de datos MySQL');
});

module.exports = connection;
