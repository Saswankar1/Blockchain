// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract loop_sol{

    uint[3] public arr;
    uint public count;

    // while
    function loop() public{
    while(count < arr.length){
        arr[count] = count;
        count++;
    }
    }
    // for
    function loop1() public{
        for(uint i=count ; i<arr.length; i++){
            arr[count] = count;
            count++;
        }
    }

    // do while
    function loop2() public{
        do{
            arr[count] = count;
            count++;
        }while(count < arr.length);
    }
    
}
