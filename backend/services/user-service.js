const Usuario = require('../models/Usuario');

const createUser = async (user, content) => {
  try {

    Usuario.create({user});
  } catch(e) {
    throw new Error(e.message)
  }
}

module.exports = {
    createUser
}
