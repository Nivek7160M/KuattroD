const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const connection = require('./db');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middlewares
app.use(cors());
app.use(bodyParser.json());

// RUTAS CRUD

// Obtener todos los usuarios (GET)
app.get('/tbl_usuario', (req, res) => {
    connection.query('SELECT * FROM tbl_usuario', (err, results) => {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json(results);
        }
    });
});

// Obtener un usuario por ID (GET)
app.get('/tbl_usuario/:Id_Usuario', (req, res) => {
    const Id_Usuario = req.params.Id_Usuario;
   
    connection.execute('SELECT * FROM tbl_usuario WHERE Id_Usuario = ?', [req.params.Id_Usuario], (err, results) => {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json(results[0]);
            console.log(1);
        }
    });
});

//  Crear un usuario (POST)
app.post('/tbl_usuario', (req, res) => {
    const { Id_Usuario, id_genero, id_area, id_rol, id_sucursal, contraseña, Id_empleado, id_contraseña, nomb_usuario} = req.body;
    connection.query('INSERT INTO tbl_usuario (Id_Usuario, id_genero, id_area, id_rol, id_sucursal, contraseña, Id_empleado, id_contraseña, nomb_usuario) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', [Id_Usuario, id_genero, id_area, id_rol, id_sucursal, contraseña, Id_empleado, id_contraseña, nomb_usuario], (err, result) => {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json({ id: result.insertId });
        }
    });
});

//  Actualizar un usuario (PUT)
app.put('/tbl_usuario/:id', (req, res) => {
    const { id } = req.params;
    const { nombre, email } = req.body;
    connection.query('UPDATE tbl_usuario SET nombre = ?, email = ? WHERE id = ?', [nombre, email, id], (err) => {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json({ id, nombre, email });
        }
    });
});

// Eliminar un usuario (DELETE)
app.delete('/tbl_usuario/Id_usuario', (req, res) => {
    const { id } = req.params;
    connection.query('DELETE FROM tbl_usuario WHERE Id_usuario = ?', [id], (err) => {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json({ mensaje: `Usuario con ID ${id} eliminado` });
        }
    });
});

// Iniciar el servidor
app.listen(PORT, () => {
    console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
