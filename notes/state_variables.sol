// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract stage{
    //  stage variables: this varibales are created in the blockchain so we have to pay some amount as a gas while making these variables
    // there are null values, with automatic value
    // variable with public create a get function automatically
    // cant assign value to it normally, age = 10(only use get funxtion or assign normally
    // it is done in compile time it we cannot add other value after compilling it
    uint public age=10; 


    function setAge() public{
        age = 10;
    }


}