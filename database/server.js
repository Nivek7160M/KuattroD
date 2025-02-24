const express = require('express');
const cors = require('cors');
const mysql = require('mysql2');
const bcrypt = require('bcrypt');
const session = require('express-session');
const nodemailer = require('nodemailer');
const crypto = require('crypto');

const app = express();  
const PORT = 3000;

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Configuración de CORS para permitir peticiones desde tu frontend
app.use(cors({
    origin: 'http://127.0.0.1:5500', // Asegúrate de que coincida con la URL desde donde ejecutas el frontend
    credentials: true
}));

// Configuración de la sesión
app.use(session({
    secret: 'secreto_super_seguro',
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false } // Cambiar a true si usas HTTPS
}));

// Configuración del transporte de Nodemailer
const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'kuattrodistribuciones@gmail.com', // Correo actualizado
        pass: 'rgne rhso xlkk fltf ' // Contraseña actualizada
    }
});

// Conexión a MySQL con Pool de Conexiones
const db = mysql.createPool({
    host: 'localhost',
    user: 'root', // Cambia esto si usas otro usuario
    password: '', // Si tienes contraseña en MySQL, agrégala aquí
    database: 'pgrrhh', // Asegúrate de que este es el nombre correcto de la BD
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

// Ruta para el login
app.post('/login', (req, res) => {
    console.log('📥 Datos recibidos en /login:', req.body);

    const { nomb_usuario, contraseña } = req.body;

    if (!nomb_usuario || !contraseña) {
        return res.status(400).json({ mensaje: 'Todos los campos son obligatorios' });
    }

    db.query('SELECT * FROM tbl_usuario WHERE nomb_usuario = ?', [nomb_usuario], (err, results) => {
        if (err) {
            console.error('❌ Error en la consulta SQL:', err);
            return res.status(500).json({ mensaje: 'Error en el servidor' });
        }

        if (results.length === 0) {
            console.log('❌ Usuario no encontrado:', nomb_usuario);
            return res.status(400).json({ mensaje: 'Usuario o contraseña incorrectos' });
        }

        const user = results[0];

        console.log('🔍 Tipo de registro:', user.Tipo_registro);
        
        if (user.Tipo_registro === 0) {
            console.log('⚠️ Se requiere cambio de contraseña para usuario:', nomb_usuario);
            return res.json({ mensaje: 'Se solicita cambio de contraseña', redirigir: '/cambiarcontraseña.html' });
        }

        bcrypt.compare(contraseña, user.contraseña, (err, result) => {
            if (err) {
                console.error('❌ Error en bcrypt.compare:', err);
                return res.status(500).json({ mensaje: 'Error en el servidor' });
            }

            if (!result) {
                console.log('❌ Contraseña incorrecta para usuario:', nomb_usuario);
                return res.status(400).json({ mensaje: 'Usuario o contraseña incorrectos' });
            }

            // Generar código de verificación
            const verificationCode = crypto.randomInt(100000, 999999);
            req.session.verificationCode = verificationCode;
            req.session.nomb_usuario = nomb_usuario;
            req.session.email = user.email;
            
            // Enviar correo con el código
            const mailOptions = {
                from: 'kuattrodistribuciones@gmail.com',
                to: user.email,
                subject: 'Código de verificación',
                text: `Tu código de verificación es: ${verificationCode}`
            };

            transporter.sendMail(mailOptions, (error, info) => {
                if (error) {
                    console.error('❌ Error enviando correo:', error);
                    return res.status(500).json({ mensaje: 'Error enviando código de verificación' });
                }
                console.log('📧 Código enviado a:', user.email);
                return res.json({ mensaje: 'Código de verificación enviado', redirigir: '/verificarcodigo.html' });
            });
        });
    });
});

// Ruta para verificar el código 2FA
app.post('/verificar-codigo', (req, res) => {
    const { codigo } = req.body;

    if (!codigo || codigo != req.session.verificationCode) {
        return res.status(400).json({ mensaje: 'Código incorrecto' });
    }

    req.session.verificationCode = null; // Eliminar código después de usarlo
    return res.json({ mensaje: 'Verificación exitosa', redirigir: '/inicio.html' });
});

// Servidor en escucha
app.listen(PORT, () => {
    console.log(`🚀 Servidor corriendo en http://localhost:${PORT}`);
});


// AUTOREGISTRO
// Verificar si existe el numero de identidad
app.get('/existencia_empl/:dni_empleado', (req, res) => {
    const dni_empleado = req.params.dni_empleado;
   
    connection.execute('SELECT cod_empleado, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido FROM tbl_empleado WHERE dni_empleado = ?', [req.params.dni_empleado], (err, results) => {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json(results[0] || null);
            console.log(1);
        }
    });
});

// Verificar si ya existe un usuario con ese numero de identidad
app.get('/existencia_usua/:cod_empleado', (req, res) => {
    const cod_empleado = req.params.cod_empleado;
   
    connection.execute('SELECT nomb_usuario FROM tbl_usuario WHERE cod_empleado = ?', [req.params.cod_empleado], (err, results) => {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json(results[0] || null);
            console.log(1);
        }
    });
});

// Verificar si ya existe el nombre de usuario
app.get('/existencia_nomb_usua', (req, res) => {
    connection.query('SELECT nomb_usuario FROM tbl_usuario', (err, results) => {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json(results);
        }
    });
});

// Crear un usuario
app.post('/crear_usua', (req, res) => {
    const { nomb_usuario, contraseña, cod_empleado, id_estado_usuario, correo } = req.body;
    connection.query('INSERT INTO tbl_usuario (nomb_usuario, contraseña, cod_empleado, id_estado_usuario, correo) VALUES (?, ?, ?, ?, ?)', [nomb_usuario, contraseña, cod_empleado, id_estado_usuario, correo], (err, result) => {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json({ id: result.insertId });
        }
    });
});
