const mongoose = require('mongoose');

const schema = new mongoose.Schema({

  idUsuario: { type: String },
  idProducto: { type: String },
  fecha: { type: Date, default: Date.now },
  titulo: { type: String },
  precio: { type: String },
  descripcion: { type: String },
  dueno: { type: String },
});

const Carrito = mongoose.model('Carrito', schema);

module.exports = Carrito;