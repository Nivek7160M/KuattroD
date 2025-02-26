// Importaciones y Configuraciones
const express = require('express');
const cors = require('cors');
const mysql = require('mysql2');
const bcrypt = require('bcryptjs');
const session = require('express-session');
const nodemailer = require('nodemailer');
const crypto = require('crypto');

const app = express();  
const PORT = 3000;

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Configuración de CORS
app.use(cors({
    origin: ['http://127.0.0.1:5500', 'http://localhost:5500'],
    credentials: true
}));

// Configuración de la sesión
app.use(session({
    secret: 'secreto_super_seguro',
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false }
}));

// Configuración del transporte de Nodemailer
const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: 'kuattrodistribuciones@gmail.com',
        pass: 'rgne rhso xlkk fltf' // ¡No compartas tu contraseña real en repositorios públicos!
    }
});

// Conexión a MySQL con Pool de Conexiones
const db = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'pgrrhh',
    waitForConnections: true,
    connectionLimit: 100,
    queueLimit: 0
});

// Verificación de conexión
db.getConnection((err, connection) => {
    if (err) {
        console.error('❌ Error al conectar con la base de datos:', err);
    } else {
        console.log('✅ Conexión exitosa a la base de datos');
        connection.release(); // Libera la conexión después de verificarla
    }
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

    req.session.verificationCode = null;
    return res.json({ mensaje: 'Verificación exitosa', redirigir: '/inicio.html' });
});

// Ruta para solicitar recuperación de contraseña
app.post('/recuperar-password', (req, res) => {
    const { email } = req.body;

    if (!email) {
        return res.status(400).json({ mensaje: 'El correo es obligatorio' });
    }

    db.query('SELECT * FROM tbl_usuario WHERE email = ?', [email], (err, results) => {
        if (err) {
            console.error('❌ Error en la consulta SQL:', err);
            return res.status(500).json({ mensaje: 'Error en el servidor' });
        }

        if (results.length === 0) {
            console.log('❌ Correo no encontrado:', email);
            return res.status(400).json({ mensaje: 'Correo no registrado' });
        }

        const otp = Math.floor(100000 + Math.random() * 900000);

        db.query('INSERT INTO tbl_otp (otp) VALUES (?)', [otp], (err) => {
            if (err) {
                console.error('❌ Error guardando OTP:', err);
                return res.status(500).json({ mensaje: 'Error en el servidor' });
            }

           const mailOptions = {
                from: 'kuattrodistribuciones@gmail.com',
                to: email,
                subject: 'Código OTP para Recuperación de Contraseña',
                text: `Hola, 
Tu código OTP para recuperar tu contraseña es: ${otp}.
Si no solicitaste este código, ignora este correo.
[KuattrioDistribuciones]`,
                html: `<p>Hola,</p><p>Tu código OTP para recuperar la contraseña es: <strong>${otp}</strong>.</p><p>Si no solicitaste este código, ignora este correo.<p><br><p>[KuattroDistribuciones]<p>`

            };

            transporter.sendMail(mailOptions, (error, info) => {
                if (error) {
                    console.error('❌ Error enviando correo:', error);
                    return res.status(500).json({ mensaje: 'Error enviando OTP' });
                }
                console.log('📧 OTP enviado a:', email);
                return res.json({ mensaje: 'OTP enviado exitosamente', redirigir: '/verificar-otp.html' });
            });
        });
    });
});

// Ruta para guardar empleados en tbl_empleado
app.post('/guardar_empleado', (req, res) => {
    const { primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, dni_empleado, fecha_nacimiento, fecha_contratacion } = req.body;

    if (!primer_nombre || !primer_apellido || !dni_empleado || !fecha_nacimiento || !fecha_contratacion) {
        return res.status(400).json({ message: 'Todos los campos obligatorios deben estar llenos.' });
    }

    const sql = `INSERT INTO tbl_empleado (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, dni_empleado, fecha_nacimiento, fecha_contratacion)
                 VALUES (?, ?, ?, ?, ?, ?, ?)`;

    db.query(sql, [primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, dni_empleado, fecha_nacimiento, fecha_contratacion], (err, result) => {
        if (err) {
            console.error('❌ Error al guardar empleado:', err);
            return res.status(500).json({ message: 'Error al guardar el empleado' });
        } else {
            console.log('✅ Empleado guardado:', result);
            return res.json({ message: 'Empleado creado exitosamente' });
        }
    });
});


// AUTOREGISTRO
const bcryptjs = require('bcryptjs'); //Importando el módulo bcryptjs

// Verificar si existe el numero de identidad
app.get('/existencia_empl/:dni_empleado', (req, res) => {
    const dni_empleado = req.params.dni_empleado;
   
    db.execute('SELECT cod_empleado, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido FROM tbl_empleado WHERE dni_empleado = ?', [req.params.dni_empleado], (err, results) => {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json(results[0] || null);
            console.log(1);
        }
    });
});

// Verificar si ya existe un usuario relacionado con ese numero de identidad
app.get('/existencia_usua/:cod_empleado', (req, res) => {
    const cod_empleado = req.params.cod_empleado;
   
    db.execute('SELECT nomb_usuario FROM tbl_usuario WHERE cod_empleado = ?', [req.params.cod_empleado], (err, results) => {
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
    db.query('SELECT nomb_usuario FROM tbl_usuario', (err, results) => {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json(results);
        }
    });
});

// Crear un usuario
app.post('/crear_usua', async (req, res) => {
    const { nomb_usuario, contraseña, cod_empleado, id_estado_usuario, correo } = req.body;
    let passwordHash = await bcryptjs.hash(contraseña, 10);

    db.query('INSERT INTO tbl_usuario (nomb_usuario, contraseña, cod_empleado, id_estado_usuario, correo) VALUES (?, ?, ?, ?, ?)', [nomb_usuario, passwordHash, cod_empleado, id_estado_usuario, correo], (err, result) => {
        if (err) {
            res.status(500).send(err);
        } else {
            res.json({ id: result.insertId });
        }
    });
});


// Iniciar el servidor
app.listen(PORT, () => {
    console.log(`🚀 Servidor corriendo en http://localhost:${PORT}`);
});
