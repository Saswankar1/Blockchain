// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract mapping_struct{ 
    
    struct student{
        uint class;
        string name;
    }

    mapping(uint=>student) public data;

    function setter(uint _roll, uint _class, string memory _name) public {
        data[_roll] = student(_class, _name);
    }

}
