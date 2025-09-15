const db = require('../db');

// list vagas, optional filter by 'local' query param
const listVagas = async (req, res) => {
  try {
    const local = req.query.local;
    if (local) {
      const q = 'SELECT id, localizacao, status FROM vagas WHERE localizacao ILIKE $1';
      const result = await db.query(q, ['%' + local + '%']);
      return res.json(result.rows);
    } else {
      const q = 'SELECT id, localizacao, status FROM vagas';
      const result = await db.query(q);
      return res.json(result.rows);
    }
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'Erro no servidor' });
  }
};

module.exports = { listVagas };
