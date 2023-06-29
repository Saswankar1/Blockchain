// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.18;

contract Donation {

    address owner;
    uint256 totalDonations;
    constructor() {
        owner = msg.sender;
    }

    struct Donation_struct {
        address donor;
        uint256 amount;
    }
    Donation_struct donation;
    Donation_struct[] donations;

    // using for receiving donations
    receive() external payable{
        donation = Donation_struct(
            msg.sender,
            msg.value
        );
        donations.push(donation);
        totalDonations += msg.value;
    }

    // it returns the donations array
    function getDonations() external view returns (Donation_struct[] memory) {
        return donations;
    }

    // it returns the totalDonations
    function getTotalDonations() external view returns (uint256) {
        return totalDonations;
    }
}
