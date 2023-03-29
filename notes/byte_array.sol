// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract array{

    // 1 bytes = 8 bit = 2 hexdecimal

    // Byte arrays: 

    // fixed size array
    bytes3 public b3; //3 bytes array
    bytes2 public b2; //2 bytes array

    function setter() public {
        b3 = 'abc'; //It will be stored as 0x616263
        b2 = 'ab'; //It will be stored as 0x6162 
    }

    // dynamic size array
    bytes public b1 = 'abc';

    function push() public {
        b1.push('b');
    }

    function getElement(uint i) public view returns(bytes1){
        return b1[i];
    }

    function getLength() public view returns(uint){
        return b1.length;
    }


    
}
