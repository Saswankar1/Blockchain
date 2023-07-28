// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/lottery.sol"; // Update the path according to your contract location

contract LotteryTest is Test {
    Lottery public lottery;
    address public owner;
    uint256 public fee;

    function setUp() public {
        fee = 1 ether; // Set the fee required to enter the lottery
        lottery = new Lottery(fee);
        owner = address(this);
    }

    function testStartLottery() public {
        assertEq(lottery.isActive(), false); // Check if the lottery is not already active

        lottery.startLottery{value: fee}(); // Start the lottery by sending the required fee
        assertEq(lottery.isActive(), true); // Check if the lottery is active after starting
    }

    function testFailStartLotteryWithInsufficientFee() public {
        // Attempt to start the lottery without sending the required fee
        vm.expectRevert(lottery.startLottery{value: fee / 2}(), "Insufficient fee");
    }

    function testPickWinner() public {
        lottery.startLottery{value: fee}(); // Start the lottery by sending the required fee
        address[] memory players = lottery.getPlayers();
        assertEq(players.length, 1); // Check if there is one player in the lottery

        lottery.pickWinner(); // Pick the winner
        assertEq(lottery.isActive(), false); // Check if the lottery is inactive after picking the winner
    }

    function testFailPickWinnerWithoutStartingLottery() public {
        // Attempt to pick the winner without starting the lottery
        vm.expectRevert(lottery.pickWinner(), "Lottery is not active");
    }

    function testFailPickWinnerWithoutPlayers() public {
        lottery.startLottery{value: fee}(); // Start the lottery by sending the required fee
        // Attempt to pick the winner without any players
        vm.expectRevert(lottery.pickWinner(), "No players in the lottery");
    }
}
