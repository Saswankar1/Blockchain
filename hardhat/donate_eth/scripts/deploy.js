const { ethers } = require("hardhat");

async function main() {
  [owner, donater1, donater2] = await ethers.getSigners();

  const Donation = await ethers.getContractFactory('Donation', owner);
  const donation = await Donation.deploy();

  console.log("Deployed to", donation.address, "by", owner.address);

  await donater1.sendTransaction({
    to: donation.address,
    value: ethers.utils.parseEther("0.01", 18)})

    await donater2.sendTransaction({
    to: donation.address,
    value: ethers.utils.parseEther("0.01", 18)})
}

// npx hardhat node
// npx hardhat run --network localhost scripts/deploy.js

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });