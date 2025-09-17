const jwt = require('jsonwebtoken');

const auth = (req, res, next) => {
  const authHeader = req.headers.authorization;
  console.log(authHeader);
  if (!authHeader) return res.status(401).json({ error: 'Token não fornecido' });
  const parts = authHeader.split(' ');
  const [scheme, token] = parts;
  if (!/^Bearer$/i.test(scheme)) return res.status(401).json({ error: 'Token mal formatado' });

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET || 'changeme');
    req.user = decoded;
    return next();
  } catch (err) {
    return res.status(401).json({ error: 'Token inválido ou expirado' });
  }


};

module.exports = auth;