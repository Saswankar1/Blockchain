// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract enum0{
    // when we assign a name to the integral value(it must have a small set)
    enum user{allowed, not_allowed, wait}
        // allowed:0
        // not allowed:1
        // wait:2

    // a enum variable
    user public u1 = user.wait;

    uint public lottery = 1000;
    function owner() public {
        if(u1 == user.allowed){
            lottery = 0;
        }
    }

    function changeOwner() public{
        u1 = user.not_allowed;
    }
}
