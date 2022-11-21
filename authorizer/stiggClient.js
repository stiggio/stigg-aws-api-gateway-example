const { default: Stigg } = require('@stigg/node-server-sdk');

if (!process.env.STIGG_SERVER_API_KEY) {
    throw new Error('Make sure you define "STIGG_SERVER_API_KEY" environment variable');
}

const stiggClient = Stigg.initialize({
    apiKey: process.env.STIGG_SERVER_API_KEY,
});

module.exports = {
    stiggClient,
}