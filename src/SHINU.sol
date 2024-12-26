// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { console } from "forge-std/console.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract SHINU is Ownable, ERC20{ 
    
    constructor() Ownable(msg.sender) ERC20("SHINU","SHINU") {
      
    }

    function mint (address _to, uint256 _amount) public onlyOwner {
        _mint(_to, _amount);
    }
    
 }
