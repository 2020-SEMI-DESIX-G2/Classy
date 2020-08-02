const mongoose = require('mongoose');

const schema = new mongoose.Schema({
  usuario: { type: String },
  contrasena: { type: String },
  email: { type: String },
  preferencias: { type: Array },
});

const Usuario = mongoose.model('Usuario', schema);

module.exports = Usuario;