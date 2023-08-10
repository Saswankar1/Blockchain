// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Will {
    address owner;
    uint fortune;
    bool isDeceased;
    address payable [] familyWallets;
    mapping(address => uint) inheritance;

    constructor() payable {
        owner = msg.sender;
        fortune = msg.value;
        isDeceased = false;
    }

    // modifiers
    modifier onlyOwner{
        require(msg.sender == owner, "You are not the owner");
        _; //-> shift to actual func after the cond is met
    }

    modifier onlyDeceased{
        require(isDeceased == true, "Grandfather is still ALIVE !!");
        _;
    }

    // set inheritance of each address
    function setInheritance(address payable wallet, uint amount) public onlyOwner {
        familyWallets.push(wallet);
        inheritance[wallet] = amount;
    }

    // pay each member based on their address
    function payout() private onlyDeceased {
        for( uint i=0; i < familyWallets.length; i++ ){
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    } 

    function deceased() public onlyOwner {
        isDeceased = true;
        payout();
    }

}