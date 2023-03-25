// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract functions{
    uint age = 20;

    // It is used to get the state variable value (use view)
    function getAge() public view returns(uint){
        return age;
    }

    // used to change the state variable using arguments
    function setAge(uint newAge) public {
        age  = newAge;
    }


}
