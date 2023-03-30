// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

struct student{
        uint roll;
        string name;
    }

contract structure{
    student public stud1;

    constructor(uint _roll, string memory _name){
        stud1.roll = _roll;
        stud1.name = _name;
    }

    function change_struct( uint _roll, string memory _name) public {
        student memory new_stud = student({
            roll: _roll,
            name: _name
        });

        stud1 = new_stud;
    }
}
