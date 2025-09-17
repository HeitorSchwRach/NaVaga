const db = require('../db');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

// Registrar novo usuário
const registerUser = async (req, res) => {
  try {
    const { nome, email, senha } = req.body;
    console.log(req.body);

    if (!nome || !email || !senha) {
      return res.status(400).json({ error: 'Nome, email e senha são obrigatórios' });
    }

    // Criptografar a senha
    const hashed = await bcrypt.hash(senha, 10);

    const insert = `
      INSERT INTO usuarios (nome, email, senha) 
      VALUES ($1,$2,$3) 
      RETURNING id, nome, email
    `;
    const result = await db.query(insert, [nome, email, hashed]);

    return res.status(201).json(result.rows[0]);
  } catch (err) {
    if (err.code === '23505') { // violação de UNIQUE (email duplicado)
      return res.status(409).json({ error: 'Email já cadastrado' });
    }
    console.error('Erro em registerUser:', err.message);
    return res.status(500).json({ error: 'Erro no servidor' });
  }
};

// Login do usuário
const loginUser = async (req, res) => {
  try {
    const { email, senha } = req.body;

    if (!email || !senha) {
      return res.status(400).json({ error: 'Email e senha são obrigatórios' });
    }

    const row = await db.query(
      'SELECT id, nome, email, senha FROM usuarios WHERE email = $1',
      [email]
    );

    if (row.rowCount === 0) {
      return res.status(401).json({ error: 'Credenciais inválidas' });
    }

    const user = row.rows[0];
    const senhaOk = await bcrypt.compare(senha, user.senha);

    if (!senhaOk) {
      return res.status(401).json({ error: 'Credenciais inválidas' });
    }

    const token = jwt.sign(
      { id: user.id, nome: user.nome, email: user.email },
      process.env.JWT_SECRET || 'changeme',
      { expiresIn: '8h' }
    );

    return res.json({ token });
  } catch (err) {
    console.error('Erro em loginUser:', err.message);
    return res.status(500).json({ error: 'Erro no servidor' });
  }
};


const getHistorico = async (req, res) => {
  try {
    const userId = parseInt(req.params.id, 10);

    if (isNaN(userId)) {
      return res.status(400).json({ error: 'ID de usuário inválido' });
    }

    if (req.user.id !== userId) {
      return res.status(403).json({ error: 'Acesso negado' });
    }

    const q = `
      SELECT 
        h.id, 
        h.vaga_id, 
        v.localizacao, 
        h.data_entrada, 
        h.data_saida
      FROM historico h
      JOIN vagas v ON v.id = h.vaga_id
      WHERE h.usuario_id = $1
      ORDER BY h.data_entrada DESC
    `;
    const result = await db.query(q, [userId]);

    return res.json(result.rows);
  } catch (err) {
    console.error('Erro em getHistorico:', err.message);
    return res.status(500).json({ error: 'Erro no servidor' });
  }
};

module.exports = { registerUser, loginUser, getHistorico };
