// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract constructors{
    // to initialise the state varaible
    // to introduce the owner of the contract
    // can only be called once
    // can create only one constructor
    // a default constructor can be created by the compile if there is no defined constructor

    uint public count;

    // now we can manually type the count value
    constructor(uint new_Count){
        count = new_Count;
    }



}