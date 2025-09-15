const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const dotenv = require('dotenv');
const usuariosRouter = require('./routes/usuarios');
const vagasRouter = require('./routes/vagas');
const sensoresRouter = require('./routes/sensores');

dotenv.config();
const app = express();
app.use(cors());
app.use(bodyParser.json());

app.use('/usuarios', usuariosRouter);
app.use('/vagas', vagasRouter);
app.use('/sensores', sensoresRouter);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`NaVaga backend running on port ${PORT}`);
});
