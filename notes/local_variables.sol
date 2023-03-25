// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract local{
    // variable declared in function and stored in stacks
    // pure: doesnt bring read/change in state variable 
    // memory is used to add or use string variable in the function
    // string is stored default in contract storage

    function store() pure public returns(uint){
        string memory name = 'raj';
        uint age = 10;
        return age;

    }

}
