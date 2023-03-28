// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract functions{
    // View: it can be used to read state variable and local varaible
    // Pure: it cannot be used to read the state variable but can be used to read the local variable 

    uint public age = 20;

    // view funtn
    function getAge() public view returns(uint){
        return age;
    }  

    // pure function
    function getRoll() public pure returns(uint){
        uint roll = 20;
        return roll;
    }


}