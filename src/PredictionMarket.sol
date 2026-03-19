//SPDX License-Modifier: MIT
pragma solidity ^0.8.33;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import  {console} from "forge-std/console.sol";

error PleaseInputQuestion();
error CreatedMarketMustBeInTheFuture();
error InputedAmountMustBeGreaterThanZero();
error CurrentMarketHasBeenResolved();
error PassedDealine();
error MarketDoesNotExist();


contract PredictionMarket is Ownable, ReentrancyGuard, IERC20, ERC20 {
    address public admin;
    IERC20 public usdc;
    uint256 platformFee = 200; // converted to 2% in sol

    mapping (uint256 => MarketDetails) markets; //markets[1] created a index of struct data
    mapping(uint256 => mapping (address => uint256)) public yesBets; //how much of yes bets did user 0x123 for market[1] YesBets[1]
    mapping(uint256 => mapping (address => uint256)) public noBets; //how much of NO bets did user 0x123 for market[1] NoBets[1]
    mapping(uint256 => mapping(address => bool)) public claimed; 

    //create oracle aggregator contract later to pass 

    uint256 public createdMarketsCount;

    struct MarketDetails {
        string question;
        uint256 deadline;
        uint256 totalYes;
        uint256 totalNo;
        bool resolved; //market ended
        bool outcome; //results
        uint256 createdAt;
    }

  constructor(address initialOwner, address _usdc) Ownable(initialOwner) {
    usdc = IERC20(_usdc); //pass testnet addr later on in dep script
  }

  function createMarket(string memory _question, uint256 _deadline) public onlyOwner() {
    if (bytes(_question).length <= 0) {
        revert PleaseInputQuestion();
    }
    if (_deadline < block.timestamp) {
        revert CreatedMarketMustBeInTheFuture();
    }
    console.log("Creating market, current count:", createdMarketsCount);
    createdMarketsCount++;
    uint256 marketId = createdMarketsCount;
    markets[marketId] = MarketDetails({
        question: _question,
        deadline: _deadline,
        totalYes: 0,
        totalNo: 0,
   resolved: false, //market ended
       outcome: false //results
       createdAt: block,timestamp;
    });
    // console.log("Market created, new count:", createdMarketsCount);
    // market new = markets({

    // })

  };

function placeBet(uint256 marketId, bool  _prediction, uint256 _amount) public {
    if (_amount == 0) {
        revert InputedAmountMustBeGreaterThanZero();
    }
    if (markets[marketId].resolved) {
        revert CurrentMarketHasBeenResolved();
    }

    if (block.timestamp < markets[marketId].deadline) {
        revert PassedDealine();
    }
    if (marketId < createdMarketsCount) {
        revert MarketDoesNotExist();
    }
    usdc.transferFrom(msg.sender, address(this), _amount);

    //placing the actual bets
    if (_prediction) {
        yesBets[marketId][msg.sender] += _amount;
        markets[marketId].totalYes += _amount;
    } else {
        noBets[marketId][msg.sender] += _amount;
        markets[marketId].totalNo += _amount;
    }
}

}