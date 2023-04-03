// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract mapping0  {
    mapping(uint => string) public roll_no;

    function setter(uint keys, string memory name) public {
        roll_no[keys] = name;
    }
}
