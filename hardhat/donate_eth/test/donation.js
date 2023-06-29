const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Donation", function() {
  let owner, donater1, donater2;
  let Donation, donation;

  beforeEach(async function() {
    [owner, donater1, donater2] = await ethers.getSigners();

    Donation = await ethers.getContractFactory('Donation');
    donation = await Donation.deploy();
  });




  describe('donating ethers', function() {
    it('should be able to donate ethers', async function() {
      const provider = waffle.provider;

      // trasnfer the ether from donater2 to owner
      await donater2.sendTransaction({
        to: donation.address,
        value: '100'
      });

      // it check if the donation is successfull
      expect(
        await provider.getBalance(donation.address)
      ).to.equal(100);
    });
  })

  describe('getting total donation', function() {
    it('return the total number of donation', async function() {
      const provider = waffle.provider;

      // trasnfer the ether from donater1 to owner
      await donater1.sendTransaction({
        to: donation.address,
        value: '100'
      });

      // trasnfer the ether from donater2 to owner
      await donater2.sendTransaction({
        to: donation.address,
        value: '100'
      });

      expect(
        await donation.connect(provider).getTotalDonations()
      ).to.equal(200)
    })
  })

  describe('getting the donations', function() {
    it('return the donators', async function() {
      const provider = waffle.provider;

      // trasnfer the ether from donater1 to owner
      await donater1.sendTransaction({
        to: donation.address,
        value: '100'
      });

      // trasnfer the ether from donater2 to owner
      await donater2.sendTransaction({
        to: donation.address,
        value: '100'
      });

      // storing the donations in the array donations
      const donations = await donation.connect(provider).getDonations();

      expect(donations[0].donor).to.equal(donater1.address);
      expect(donations[0].amount).to.equal('100');
    })
  })

})