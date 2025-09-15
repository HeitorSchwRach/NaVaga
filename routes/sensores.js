const express = require('express');
const router = express.Router();
const { sensorEvent } = require('../controllers/sensores');

router.post('/vagas', sensorEvent);

module.exports = router;
