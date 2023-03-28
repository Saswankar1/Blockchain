// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract array{

    // Fixed size array: we know the length of the array in the compile time
    uint[5] public arr = [10,20,30,40,50];

    function setter(uint index, uint value) public {
        arr[index] = value;
    }

    // return length
    function length() public view returns(uint){
        return arr.length;
    }

    // dynamic size array: size can be changed during compile time
    uint[] public arr1;
    // can perform push , pop

    function pushElement(uint item) public {
        arr1.push(item);
    }

    function popElement() public {
        arr1.pop();
    }
}
