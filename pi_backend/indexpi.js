// pi_backend/indexpi.js

const express = require('express');
const app = express();
const PORT = 3000;
const bcrypt = require('bcrypt');
const mysql = require('mysql'); 
const cors = require('cors'); 



const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '', 
    database: 'ficha/informe'     
});

db.connect(err => {
    if (err) {
        console.error('Error al conectar a MySQL:', err);
        return;
    }
    console.log('Conexión a MySQL establecida.');
});


// 2. Middleware esencial
app.use(express.json()); 
app.use(cors()); // Permite peticiones desde Flutter


// 3. RUTA DE PRUEBA (GET /)
app.get('/', (req, res) => {
  res.send('¡Servidor del Backend de PI (Node.js/Express) está funcionando!');
});


// 4. 🔑 RUTA DE AUTENTICACIÓN (POST /login)
app.post('/login', (req, res) => {
    console.log('-------------------------------------------');
    console.log('¡SOLICITUD DE LOGIN RECIBIDA!');
    
    // Obtiene los campos enviados desde Flutter
    const { correo, contrasenia } = req.body; 
    console.log(`Intentando login para: ${correo}`);
    
    if (!correo || !contrasenia) {
        return res.status(400).json({ message: 'Faltan campos (correo o contrasenia).' });
    }
    
    // ⚠️ PASO 2: LÓGICA DE BÚSQUEDA Y COMPARACIÓN CON MYSQL
    // Busca al profesor por email y que esté activo
    db.query('SELECT * FROM profesor WHERE email = ? AND activo = 1', [correo], (err, results) => {
        if (err) {
            console.error('Error al buscar profesor:', err);
            return res.status(500).json({ message: 'Error interno del servidor.' });
        }
        
        // El profesor no existe o no está activo
        if (results.length === 0) {
            console.log('Error: Profesor no encontrado o inactivo.');
            return res.status(401).json({ message: 'Credenciales no válidas.' });
        }
        
        const profesorEnDB = results[0]; // Primer resultado (el profesor)
        const storedHash = profesorEnDB.password_hash; // El hash de la DB

        // Comparar la contraseña plana de Flutter con el hash de la DB
        bcrypt.compare(contrasenia, storedHash, (err, result) => {
            if (err) {
                console.error('Error al comparar hash:', err);
                return res.status(500).json({ message: 'Error interno del servidor.' });
            }
            
            if (result) {
                console.log('¡Autenticación exitosa!');
                // Éxito: Devuelve 200/202 y los datos del profesor
                return res.status(200).json({ 
                    message: 'Login exitoso', 
                    // Se devuelve la data que Flutter necesita
                    profesor: { 
                        id: profesorEnDB.id, 
                        nombre: profesorEnDB.nombre,
                        email: profesorEnDB.email,
                        rol: profesorEnDB.rol 
                    } 
                });
            } else {
                // Contraseña incorrecta
                console.log('Error: Contraseña no coincide.');
                return res.status(401).json({ message: 'Credenciales no válidas.' });
            }
        });
    });
});


// 5. Iniciar el servidor
app.listen(PORT, () => {
  console.log(`Servidor de Node.js ejecutándose en http://localhost:${PORT}`);
});