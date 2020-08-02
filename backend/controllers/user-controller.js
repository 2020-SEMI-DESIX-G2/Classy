const { userService } = require('../services')

const { createUser } = userService

const postUser = async (req, res, next) => {

  const user = req.body

  try {
    await createUser(user)

    res.sendStatus(201)
    next()
  } catch(e) {
    console.log(e.message)
    res.sendStatus(500) && next(error)
  }
}

module.exports = {
    postUser
}