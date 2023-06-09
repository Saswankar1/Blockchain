// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract GCDTest {

    //this function calculates the GCD (Greatest Common Divisor)
    function gcd(uint a, uint b) public pure returns (uint) {
        uint ans = 0;
        for(uint i=1; i <= a && i <= b; ++i){
            if(i%a==0 && i%b==0){
                ans = i;
            }
        }

        return ans;

        
    }

}
