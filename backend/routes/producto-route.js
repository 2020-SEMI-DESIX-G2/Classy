const productoRouter = require('express').Router();
const Producto = require('../models/Producto');

productoRouter.post('/producto', async (req, res) => {
    
    const {
        titulo,
        precio,
        descripcion,
        dueno
    } = req.body;

    let payload = await Producto.create({ titulo, precio, descripcion, dueno });
    res.json({
        payload
    });
});

productoRouter.get('/producto', async (req, res) => {

    const productos = await Producto.find().select('titulo precio descripcion dueno');

    res.status(200).json({
        'payload': {
            productos,
            cantidad: productos.length
        }
    });});

module.exports = productoRouter