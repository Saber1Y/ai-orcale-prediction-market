//SPDX License-Modifier: MIT
pragma solidity ^0.8.33;
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract PredictionMarket {
    address public admin;
    IERC20 public usdc;
    uint256 platformFee = 200 // converted to 2% in sol

    mapping (uint256 => MarketDetails) markets; //markets[1] created a index of struct data
    mapping(uint256 => mapping (address => uint256)) public YesBets; //how much of yes bets did user 0x123 for market[1] YesBets[1]
    mapping(uint256 => mapping (address => uint256)) public NoBets; //how much of NO bets did user 0x123 for market[1] NoBets[1]
    maqpping(uint256 => mapping(address => bool)) public claimed; 

    uint256 public createdMarketsCount;

    struct MarketDetails {
        string question;
        uint256 deadline;
        uint256 totalYes;
        uint256 totalNo;
        bool resolved; //market ended
        bool outcome; //results
    }

  constructor(address initialOwner) Ownable(initialOwner) {}
}