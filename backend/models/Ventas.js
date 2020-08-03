const mongoose = require('mongoose');

const schema = new mongoose.Schema({

  idUsuario: { type: String },
  total: { type: String },
  fecha: { type: Date, default: Date.now },
  productos: { type: Array },
});

const Ventas = mongoose.model('Ventas', schema);

module.exports = Ventas;