require('dotenv').config()
const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const routes = require('./routes/user-router');

const connectDb = require('./dbConfig');
const PORT = 3000;

// Se indica el directorio donde se almacenarán las plantillas 
//app.set('views', './views');

// Se indica el motor del plantillas a utilizar
//app.set('view engine', 'pug');

app.use(bodyParser.json());
//app.use(bodyParser.urlencoded());

app.get('/', (req, res) => res.send('App is working'))
 
app.use('/api', routes)

connectDb().then(() => {
    app.listen(PORT, () => {
      console.log(`Ejecutando en el puerto ${PORT}`);
    });
});