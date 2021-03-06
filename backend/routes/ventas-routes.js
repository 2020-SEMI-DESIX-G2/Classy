const ventasRouter = require('express').Router();
const Ventas = require('../models/Ventas');

ventasRouter.post('/ventas', async (req, res) => {
    
    const {
        idUsuario,
        productos,
        total
    } = req.body;

    let payload = await Ventas.create({ idUsuario, productos, total });
    res.json({
        payload
    });
});

ventasRouter.get('/ventas/:id', async (req, res) => {

    try {

        const ventas = await Ventas.find({idUsuario: req.params.id}).select('total idUsuario productos fecha');
        res.status(200).json({
            'payload': {
                ventas,
                cantidad: ventas.length
            }
        });
    } catch (error) {
        console.log(error);
        res.status(200).json({
            'payload': {
                ventas: [],
                cantidad: 0
            }
        });
    }
});

ventasRouter.delete('/ventas/:id', async (req, res) => {

    try {

        await Ventas.findOneAndDelete(req.params.id);
        res.status(200).json({
            "id": req.params.id
        });   
    } catch (error) {
        console.log(error);
        res.status(500).json({
            "id": req.params.id
        });   
    }
});

module.exports = ventasRouter