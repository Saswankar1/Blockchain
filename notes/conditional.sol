// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract cond_sol{
    function conditional(int a ) public pure returns(string memory){
        string memory value;

        if(a>0){
            value = "greater than zero";
        }else if(a == 0){
            value = "equal to zero";
        }else{
            value = "smaller than zero";
        }

        return value;
    }
}
