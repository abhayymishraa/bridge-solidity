// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { console } from "forge-std/console.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";


contract BridgeETH is Ownable {
    uint256 public balance;
    address public tokenAddress;

    event Deposit(address indexed depositor, uint amount);
    
    mapping(address => uint256) pendingBalance;

    constructor() Ownable(msg.sender) {
    
    }

    function deposit(IERC20 _tokenAddress, uint256 _amount) public {
     require(address(_tokenAddress) == tokenAddress);
     require(_tokenAddress.allowance(msg.sender, address(this)) >= _amount);
     require(_tokenAddress.transferFrom(msg.sender, address(this), _amount));
     pendingBalance[msg.sender] += _amount;
     emit Deposit(msg.sender, _amount);
    }

    function witdraw(IERC20 _tokenAddress, uint256 _amount) public {
     require(address(_tokenAddress) == tokenAddress);
     require(pendingBalance[msg.sender] >= _amount);
     pendingBalance[msg.sender] -= _amount;
     _tokenAddress.transfer(msg.sender, _amount);
    }

    function burnedOnOtherSide(address _user,uint256 _amount) public onlyOwner {
      pendingBalance[_user] += _amount;
    }

}
