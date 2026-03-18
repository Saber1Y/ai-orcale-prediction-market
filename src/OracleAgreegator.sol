//SPDX-License-Identifier: MIT
pragma solidity ^0.8.33;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
// import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract OracleAggregator is Ownable {
    constructor(address initialOwner) Ownable(initialOwner) {
        
    }
}
