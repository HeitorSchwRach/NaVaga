const { Pool } = require('pg');
require('dotenv').config();

// Configurações do banco de dados
const db = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

// Testando a conexão
db.connect((err, client, release) => {
  if (err) {
    return console.error('Erro ao conectar ao banco de dados:', err.stack);
  }
  console.log('Conexão com o banco de dados estabelecida com sucesso!');
  release();
});

// Exportando o db para ser usado em outros arquivos
module.exports = db;