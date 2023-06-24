const { ethers } = require("hardhat");
const { expect } = require("chai");

describe("SolitudeCoin", function () {
  let SolitudeCoin;
  let solitudeCoin;
  let owner;
  let addr1;
  let addr2;

  before(async function () {
    SolitudeCoin = await ethers.getContractFactory("SolitudeCoin");
    [owner, addr1, addr2] = await ethers.getSigners();
  });

  beforeEach(async function () {
    solitudeCoin = await SolitudeCoin.deploy();
  });

  it("Should have correct name, symbol, and initial supply", async function () {
    expect(await solitudeCoin.name()).to.equal("SolitudeCoin");
    expect(await solitudeCoin.symbol()).to.equal("STC");
    expect(await solitudeCoin.totalSupply()).to.equal(ethers.utils.parseUnits("100000", 18));
  });

  it("Should mint tokens", async function () {
    await solitudeCoin.mint(addr1.address, ethers.utils.parseUnits("50000", 18));
    expect(await solitudeCoin.balanceOf(addr1.address)).to.equal(ethers.utils.parseUnits("50000", 18));
  });

  it("Should burn tokens", async function () {
    await solitudeCoin.burn(ethers.utils.parseUnits("10000", 18));
    expect(await solitudeCoin.totalSupply()).to.equal(ethers.utils.parseUnits("90000", 18));
  });

  it("Should have maximum supply", async function () {
    const maxSupply = ethers.utils.parseUnits("1000000", 18);
    expect(await solitudeCoin.totalSupply()).to.equal(maxSupply);
  });
  
  it("Should set block reward", async function () {
    const newBlockReward = ethers.utils.parseUnits("10", 18);
    await solitudeCoin.setBlockReward(newBlockReward);
    expect(await solitudeCoin.blockReward()).to.equal(newBlockReward);
  });
  

});
