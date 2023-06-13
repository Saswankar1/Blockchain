// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/*
In this contract:
    1. sell from the stock
    2. add to stock
    3. check the stock data
    4. check the transaction
    5. check the number of transaction
*/

contract Shop  {

    uint stock = 0;
    int[] transaction;

    //this function allows gavin to buy n chocolates
    function buy(uint n) public {
        require(n < 2**256 - 1, "Max amount reached");
        stock += n;
        transaction.push(int(n));

    }

    //this function allows gavin to sell n chocolates
    function sell(uint n) public {
        require(n < 2**256 - 1, "Max amount reached");
        stock -= n;
        transaction.push(-int(n));

    }

    //this function returns total number of chocolates in bag
    function stock_data() public view returns(uint n) {
        return stock;
    }

    // this function returns the nth transaction
    function showTransaction(uint n) public view returns(int) {
        return transaction[n];
    }

    //this function returns the total number of transactions
    function numberOfTransactions() public  view returns(uint) {
        return transaction.length;
    }



}
