const mongoose = require('mongoose');

const schema = new mongoose.Schema({
  titulo: { type: String },
  precio: { type: String },
  descripcion: { type: String },
  fecha: { type: Date, default: Date.now },
  dueno: { type: String },
});

const Producto = mongoose.model('Producto', schema);

module.exports = Producto;