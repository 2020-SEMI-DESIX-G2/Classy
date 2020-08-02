const userRouter = require('express').Router();
const Usuario = require('../models/Usuario');
const bcrypt = require("bcryptjs");

userRouter.post('/register', async (req, res) => {
    
    let {
        usuario, 
        contrasena, 
        email,  
        preferencias
    } = req.body;

    const salt = await bcrypt.genSalt(10);
    contrasena = await bcrypt.hash(contrasena, salt);

    await Usuario.create({ usuario, contrasena, email, preferencias });
    res.json({
        usuario,
        email,  
        preferencias
    });
});

userRouter.post('/login', async (req, res) => {

    const {
        usuario,
        contrasena
    } = req.body;

    let user = await Usuario.findOne({ usuario });

    if (!user)
        return res.status(400).json({
          message: "El usuario no existe"
        });

    const isMatch = await bcrypt.compare(contrasena, user.contrasena);

    if (!isMatch)
        return res.status(400).json({
            message: "Contraseña incorrecta !"
    });

    res.status(200).json({
        'payload': {
            'usuario': user.usuario,
            'email': user.email,
            'preferencias': user.preferencias
        }
    });});

module.exports = userRouter