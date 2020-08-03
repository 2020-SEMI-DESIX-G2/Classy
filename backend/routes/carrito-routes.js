const carritoRouter = require('express').Router();
const Carrito = require('../models/Carrito');

carritoRouter.post('/carrito', async (req, res) => {
    
    const {
        idUsuario,
        idProducto,
        titulo,
        precio,
        descripcion,
        dueno
    } = req.body;

    let payload = await Carrito.create({ idUsuario, idProducto, titulo, precio, descripcion, dueno });
    res.json({
        payload
    });
});

carritoRouter.get('/carrito/:id', async (req, res) => {

    try {

        const carritos = await Carrito.find({idUsuario: req.params.id}).select('fecha idProducto titulo precio descripcion dueno');
        res.status(200).json({
            'payload': {
                carritos,
                cantidad: carritos.length
            }
        });
    } catch (error) {
        console.log(error);
        res.status(200).json({
            'payload': {
                carritos: [],
                cantidad: 0
            }
        });
    }
});

carritoRouter.delete('/carrito/:id', async (req, res) => {

    try {

        await Carrito.findOneAndDelete(req.params.id);

    } catch (error) {
        console.log(error);
        res.status(200).json({
            'payload': {
                carritos: [],
                cantidad: 0
            }
        });
    }
});

module.exports = carritoRouter