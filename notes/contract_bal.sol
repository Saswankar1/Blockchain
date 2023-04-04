// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract contract_bal{

    // transfer ether to the user
    address payable user = payable(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);

    // payable is used to transfer ether in the contract
    function pay_ether() public payable {

    }

    // it returns the balance of the contract 
    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function sendEtherAccount() public {
        user.transfer(1 ether);
    }
}
