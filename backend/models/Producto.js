const mongoose = require('mongoose');

const schema = new mongoose.Schema({
  titulo: { type: String },
  precio: { type: String },
  descripcion: { type: String },
  dueno: { type: String },
});

const Producto = mongoose.model('Producto', schema);

module.exports = Producto;