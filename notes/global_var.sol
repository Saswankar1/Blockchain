
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract glob_var{
    
   function demo() public view returns(uint block_no, uint timestamp, address msgSender){
       return(block.number, block.timestamp, msg.sender);
   }

}
