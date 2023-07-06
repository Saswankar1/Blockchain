// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "../src/Wallet.sol";

contract WalletTest is Test {
    Wallet public wallet;

    function setUp() public {
        wallet = new Wallet();
        // Add the test contract's address as an approved address
        wallet.addAccess(address(this));
    }

    // for add funds
    function testaddFunds() public {
        wallet.addFunds(500);
        assertEq(wallet.wallet_balance(), 500);
    }

    // when funds are more than 10K
    function testFailaddFunds() public {
        wallet.addFunds(50000);
        assertEq(wallet.wallet_balance(), 500);
    }

    // for spend funds
    function testspendFunds() public {
        // adding some funds to wallet
        wallet.addFunds(500);
        assertEq(wallet.wallet_balance(), 500);

        // calling the spend function
        wallet.spendFunds(100);
        assertEq(wallet.wallet_balance(), 400);
    }

    // when spend amount > balance
    function testFailspendFunds() public {
        // adding some funds to wallet
        wallet.addFunds(500);
        assertEq(wallet.wallet_balance(), 500);

        // calling the spend function
        wallet.spendFunds(1000);
    }

    // view balance
    function testviewBalance() public {
        // adding some funds to wallet
        wallet.addFunds(500);
        assertEq(wallet.viewBalance(), 500);
    }

}
