// SPDX-License-Identifier: MIT
const { expect } = require("chai");
const { ethers, waffle } = require("hardhat");
const { deployContract, solidity } = waffle;

const { utils } = ethers;

describe("Lottery", function () {
  let Lottery;
  let lottery;
  let owner;
  let players;

  beforeEach(async function () {
    [owner, ...players] = await ethers.getSigners();

    // Deploy the Lottery contract
    Lottery = await ethers.getContractFactory("Lottery");
    lottery = await deployContract(owner, Lottery, [utils.parseEther("0.1")]);
  });

  it("should allow players to enter the lottery", async function () {
    const initialPrizePool = await lottery.prizePool();
    const fee = await lottery.fee();
    const playerAddress = players[0].address;

    // Start the lottery by sending the required fee
    await lottery.connect(players[0]).startLottery({ value: fee });

    // Verify that the player has entered the lottery and prize pool increased
    expect(await lottery.getPlayers()).to.eql([playerAddress]);
    expect(await lottery.prizePool()).to.equal(initialPrizePool.add(fee));
  });

  it("should not allow non-owners to pick the winner", async function () {
    // Start the lottery
    await lottery.startLottery({ value: await lottery.fee() });

    // Attempt to pick the winner by a non-owner
    await expect(lottery.connect(players[0]).pickWinner()).to.be.revertedWith("Only the owner can access this function");
  });

  it("should pick a winner and distribute the prize pool", async function () {
    const fee = await lottery.fee();

    // Start the lottery by sending the required fee
    await lottery.startLottery({ value: fee });

    const initialBalance = await ethers.provider.getBalance(players[0].address);

    // Pick the winner by the owner
    await lottery.pickWinner();

    const finalBalance = await ethers.provider.getBalance(players[0].address);

    // Verify that the prize pool was distributed to the winner
    expect(finalBalance.sub(initialBalance)).to.equal(fee);
    expect(await lottery.prizePool()).to.equal(0);
  });

  it("should revert when trying to pick a winner with no players", async function () {
    // Start the lottery by sending the required fee
    await lottery.startLottery({ value: await lottery.fee() });

    // Pick the winner by the owner
    await lottery.pickWinner();

    // Attempt to pick the winner again when there are no players
    await expect(lottery.pickWinner()).to.be.revertedWith("No players in the lottery");
  });

});
