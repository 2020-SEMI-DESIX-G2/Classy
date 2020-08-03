require('dotenv').config()
const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const userRoutes = require('./routes/user-router');
const productoRoutes = require('./routes/producto-route');
const carritoRouter = require('./routes/carrito-routes');
const ventasRouter = require('./routes/ventas-routes');

const connectDb = require('./dbConfig');
const PORT = 3000;

app.use(bodyParser.json());

app.get('/', (req, res) => res.send('App is working'))
 
app.use('/api', userRoutes)
app.use('/api', productoRoutes)
app.use('/api', carritoRouter)
app.use('/api', ventasRouter)

connectDb().then(() => {
    app.listen(PORT, () => {
      console.log(`Ejecutando en el puerto ${PORT}`);
    });
});