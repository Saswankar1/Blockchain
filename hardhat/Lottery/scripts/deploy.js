const { ethers } = require("hardhat");

async function main() {
  // Deploy the Lottery contract
  const Lottery = await ethers.getContractFactory("Lottery");
  const lottery = await Lottery.deploy(0.1 * 10 ** 18); // Pass the required fee in wei (0.1 ETH in this example)

  await lottery.deployed();

  console.log("Lottery contract deployed to:", lottery.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
