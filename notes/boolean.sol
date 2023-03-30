// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract boolean{
    
    bool public value;

    function check(uint a ) public returns(bool){
        if(a>100){
            value = true;
        }else{
            value = false;
        }

        return value;
    }

}
