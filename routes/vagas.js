const express = require('express');
const router = express.Router();
const { listVagas } = require('../controllers/vagas');

router.get('/', listVagas);

module.exports = router;
