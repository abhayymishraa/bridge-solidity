// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;


import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { console } from "forge-std/console.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

interface WSHINU is IERC20 {
   function mint(address _to, uint256 _amount) external;
    function burn(address _from, uint256 _amount) external;
}


contract BridgeBASE is Ownable {
   uint256 public balance;
   address public tokenAddress;

   event Burn(address indexed burner, uint256 amount);

   mapping(address=>uint256) public pendingBalance;

   constructor() Ownable(msg.sender){

   }

   function withdraw(WSHINU _tokenAddress, uint256 _amount) public {
     require(pendingBalance[msg.sender] >= _amount);
     pendingBalance[msg.sender] -= _amount;
     _tokenAddress.mint(msg.sender, _amount);
   }

   function burn(WSHINU _tokenAddress,uint256 _amount) public {
     require(address(_tokenAddress) == tokenAddress);
     _tokenAddress.burn(msg.sender, _amount);
     emit Burn(msg.sender, _amount);
   }

   function depositHappenedonOtherSide( address _account,uint256 _amount) public onlyOwner{
     pendingBalance[_account] += _amount;
   }

}