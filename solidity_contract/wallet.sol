// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;


contract Contract {

    uint public balance;
    function deposit() public payable {
        balance += msg.value;
    }

    function getBalance() public  view returns(uint){
        return address(this).balance;

    }
    
    function withdrawAll() public {
        address payable Sec_contract = payable(msg.sender);
        Sec_contract.transfer(getBalance());
    }

    function withdrawToContract(address payable to, uint amount ) public {
        to.transfer(amount);
    }
}
