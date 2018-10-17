const path = require('path');
const fs = require('fs');
const solc = require('solc');

const contractsPath = path.resolve(__dirname, 'contracts', 'auctionify.sol');
const compiledPath = path.resolve(__dirname, 'compiled');
const compiledFile = path.resolve(compiledPath, 'auctionify.js');

const source = fs.readFileSync(contractsPath, 'UTF-8');

const compiled = solc.compile(source, 1).contracts[':Auctionify'];

const bytecode = compiled.bytecode;
const API = JSON.parse(compiled.interface);


if (!fs.existsSync(compiledPath)) fs.mkdirSync(compiledPath);

fs.writeFileSync(compiledFile, `module.exports = ${JSON.stringify({bytecode, API}, null, 2)};`);
