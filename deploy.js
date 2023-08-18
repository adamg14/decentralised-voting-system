const ethers = require("ethers");
const fs = require("fs-extra");
const path = require("path");
require("dotenv").config();

async function main(){
    // Connect to the blockchain using the RPC URL - in this instance the Sepolia ETH testnet
    const provider = new ethers.JsonRpcProvider(process.env.RPC_URL);
    const wallet = new ethers.Wallet(process.env.WALLET_PRIVATE_KEY, provider);

    const abiPath = path.join(__dirname, "Election_sol_Election.abi");
    const binaryPath = path.join(__dirname, "Election_sol_Election.bin")

    const abi = fs.readFileSync(abiPath, "utf8");
    const binary = fs.readFileSync(binaryPath, "utf-8");

    const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
    console.log("Deploying the smart contract to the blockchain...");
    const contract = await contractFactory.deploy();
    await contract.waitForDeployment();
    const contractAddress = await contract.getAddress();
    console.log("Smart Contract Address: " + contractAddress);
    console.log("Smart Contract deployed.");

    // the smart contract has been deployed and can be interacted with  
}

main().then(function(){
    process.exit(0);
}).catch(function(error){
    console.log(error);
    process.exit(1);
});