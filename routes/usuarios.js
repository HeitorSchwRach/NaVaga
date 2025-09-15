const express = require('express');
const router = express.Router();
const { registerUser, loginUser, getHistorico } = require('../controllers/usuarios');
const auth = require('../middlewares/auth');

router.post('/', registerUser);
router.post('/login', loginUser);
router.get('/:id/historico', auth, getHistorico);

module.exports = router;
