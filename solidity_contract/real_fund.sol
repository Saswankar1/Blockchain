// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

error NotOwner();

contract fundMe{
    address owner;
    constructor(){
        owner = msg.sender;
    }

    mapping(address => uint) public addressToAmount;
    uint public minEth = 0.001 ether;

    modifier onlyOwner() {
        if(msg.sender != owner) revert NotOwner();
        _;
    }

    function fund(uint _amount) public payable{
        require(_amount > minEth, "Send at least 0.001 eth");
        addressToAmount[owner] += _amount;
        (bool success, ) = payable(owner).call{value: _amount}("");
        require(success, "Funding failed");
    }
    
    function  withdraw(uint _amount) public {
        require(_amount <= addressToAmount[msg.sender], "Insufficient balance");
        require(address(this).balance >= _amount, "Contract balance is insufficient");

        // Deduct the amount from the sender's balance within the contract
        addressToAmount[msg.sender] -= _amount;

        // Deduct the amount from the owner's external wallet
        addressToAmount[owner] -= _amount;

        // Transfer the amount from the owner's external wallet to the sender's external wallet
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Withdrawal failed");

    }

    function funder_balance(address _add) public view returns(uint){
        return addressToAmount[_add];
    }
    
    function owner_balance() public view returns(uint){
        return addressToAmount[owner];
    }
}
