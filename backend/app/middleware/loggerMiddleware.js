// middleware/loggerMiddleware.js
const logger = require('../logger');

const logRequest = (req, res, next) => {
  const logEntry = {
    level: 'info',
    route: req.originalUrl,
    ipAddress: req.ip
  };
  res.on('finish', () => {
    logEntry.status = res.statusCode;
    if (res.statusCode >= 400) {
      logEntry.level = 'error';
    } else if (res.statusCode >= 300) {
      logEntry.level = 'warn';
    }
    logger.log(logEntry);
  });
  next();
};

module.exports = logRequest;g
