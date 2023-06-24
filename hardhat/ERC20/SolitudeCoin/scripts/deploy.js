const { ethers } = require("hardhat");

async function main() {
  // Get the contract factory
  const SolitudeCoin = await ethers.getContractFactory("SolitudeCoin");

  // Deploy the contract
  console.log("Deploying SolitudeCoin...");
  const contract = await SolitudeCoin.deploy();

  // Wait for the contract to be mined
  await contract.deployed();

  console.log("SolitudeCoin deployed to:", contract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
