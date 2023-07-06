// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Wallet {

    // variables for the owner of the contract, balance of the wallet, approved address by the owner
    address public owner;
    uint public wallet_balance;
    mapping(address => bool) private approved_add;

    //setting the sender as the owner
    constructor() {
        owner = msg.sender;
    }

    // Modifiers in Solidity are reusable pieces of code that can be added to function declarations in order to modify the behavior of those functions.
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }

    modifier onlyApproved() {
        require(approved_add[msg.sender], "Only approved addresses can call this function.");
        _;
    }

    //this function allows adding funds to wallet
    function addFunds(uint amount) public onlyApproved {
        require(wallet_balance < 10000, "Fund exceeds the limit");
        wallet_balance += amount;
    }

    //this function allows spending an amount to the account that has been granted access by owner
    function spendFunds(uint amount) public onlyApproved {
        require(wallet_balance > amount, "Insufficient balance");
        wallet_balance -= amount;

    }

    // Note: Mappign used is almost like a dictionary in python
    //this function grants access to an account and can only be accessed by owner
    function addAccess(address x) public onlyOwner{
        approved_add[x] = true;
    }

    //this function revokes access to an account and can only be accessed by owner
    function revokeAccess(address x) public onlyOwner{
        approved_add[x] = false;
    }

    //this function returns the current balance of the wallet
    function viewBalance() public view onlyApproved returns(uint) {
        return wallet_balance;
    }

}