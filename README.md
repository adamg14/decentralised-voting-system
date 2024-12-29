# Decentralised Voting System
A decentralized application (dApp) for conducting secure and transparent elections, utilizing Ethereum smart contracts deployed via the ethers.js library. This smart contract was deployed to the Sepolia Ethereum Testnet.

## Features
- __Secure Voting:__ Ensures voter anonymity and prevents double voting.
- __Transparency:__ Votes are recorded on the Ethereum blockchain, providing an immutable and transparent ledger.
- __Decentralisation:__ Eliminates the need for a central authority to manage elections.

## Prerequisites
The following is required to run the application:
- [Node.js](https://nodejs.org/en).
- [Node Package Manager](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)
- [ethers.js](https://docs.ethers.org/v5/).
- Access to the Ethereum mainnet or testnet.

## Installation
1. Clone the Repository:
```bash
git clone https://github.com/adamg14/decentralised-voting-system.git
cd decentralised-voting-system
```

2. Install Dependencies:
```bash
npm install
```
3. Compiling the smart contract:
```bash
   npx solcjs --bin --abi Election.sol
```

4. Deploying the contract to the Ethereum network:
```bash
node deploy.js
```

## Usage
1. Interact with the deployed contract using the ethers.js library to connect to the Ethereum network and interact with the deployed smart contract.
2. Cast a vote: with the candidate ID, execute the vote function from the Election contract
3. Use the 'getResult' function to obtain the current vote counts for all candidates
