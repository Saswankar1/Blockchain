// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Coin {
    error lessBalance(uint requested, uint available);
    
   address public minter;
   mapping(address => uint) public balances;

   event Sent(address from, address to, uint amount);

   constructor(){
       minter = msg.sender;
   }

   modifier onlyOnwer(){
       require(msg.sender == minter);
       _;
   }

    // make new coins and send them to an address
   function mint(address receiver, uint amount) onlyOnwer public  {
       balances[receiver] += amount;
   }

    // sent any amount of coins to an existing address
    function send(address receiver, uint amount) public {
        if (amount > balances[receiver]){
            revert lessBalance({
                requested: amount,
                available: balances[receiver]
            });
        }
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
    }
}