const db = require('../db');

const sensorEvent = async (req, res) => {
  try {
    const { codigo_sensor, status, usuario_id } = req.body;
    if (!codigo_sensor || !status) return res.status(400).json({ error: 'codigo_sensor e status são obrigatórios' });
    if (!['livre', 'ocupada'].includes(status)) return res.status(400).json({ error: 'status inválido' });

    const s = await db.query('SELECT * FROM sensores WHERE codigo_sensor = $1', [codigo_sensor]);
    if (s.rowCount === 0) return res.status(404).json({ error: 'sensor não encontrado' });
    const sensor = s.rows[0];
    if (!sensor.vaga_id) return res.status(400).json({ error: 'sensor não está vinculado a nenhuma vaga' });

    await db.query('UPDATE vagas SET status = $1 WHERE id = $2', [status, sensor.vaga_id]);

    if (status === 'ocupada') {
      if (usuario_id) {
        await db.query('INSERT INTO historico (usuario_id, vaga_id, data_entrada) VALUES ($1,$2,NOW())', [usuario_id, sensor.vaga_id]);
      } else {
        await db.query('INSERT INTO historico (usuario_id, vaga_id, data_entrada) VALUES ($1,$2,NOW())', [null, sensor.vaga_id]);
      }
    } else {
      const last = await db.query('SELECT id FROM historico WHERE vaga_id = $1 AND data_saida IS NULL ORDER BY data_entrada DESC LIMIT 1', [sensor.vaga_id]);
      if (last.rowCount > 0) {
        await db.query('UPDATE historico SET data_saida = NOW() WHERE id = $1', [last.rows[0].id]);
      }
    }

    return res.json({ ok: true, vaga_id: sensor.vaga_id, status });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'Erro no servidor' });
  }
};

module.exports = { sensorEvent };
