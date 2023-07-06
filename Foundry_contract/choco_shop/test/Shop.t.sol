// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Shop.sol";

contract ShopTest is Test {
    Shop public shop; // Instance of the Shop contract to be tested

    function setUp() public {
        shop = new Shop(); // Deploy a new instance of the Shop contract before each test
    }

    function testbuy() public {
        shop.buy(20);
        assertEq(shop.stock(), 20); // Check if the stock is correctly updated after buying chocolates
    }

    function testFailbuy() public {
        shop.buy(2**256 - 1); // Attempt to buy the maximum possible amount, expecting the transaction to fail
    }

    function testsell() public {
        shop.buy(20);
        assertEq(shop.stock(), 20); // Check if the stock is correctly updated after buying chocolates

        shop.sell(10);
        assertEq(shop.stock(), 10); // Check if the stock is correctly updated after selling chocolates
    }

    function testFailsell() public {
        shop.sell(2**256 - 1); // Attempt to sell the maximum possible amount, expecting the transaction to fail
    }

    function teststock_data() public {
        shop.buy(20);
        assertEq(shop.stock(), 20); // Check if the stock is correctly updated after buying chocolates

        assertEq(shop.stock_data(), shop.stock()); // Check if the stock_data function returns the correct stock value
    }

    function testshowtransaction() public {
        shop.buy(20);
        shop.buy(10);

        assertEq(shop.showTransaction(1), 10); // Check if the showTransaction function returns the correct transaction value
    }

    function testnumberOfTransactions() public {
        shop.buy(20);
        shop.buy(10);

        assertEq(shop.numberOfTransactions(), 2); // Check if the numberOfTransactions function returns the correct number of transactions
    }
}
