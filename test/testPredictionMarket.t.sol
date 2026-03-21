//SPDX License-Modifier: MIT
pragma solidity ^0.8.33;
import {Test, console} from "forge-std/Test.sol";
import {PredictionMarket} from "../src/PredictionMarket.sol";
import {MockUSDC} from "./mocks/MockUSDC.sol";

contract testPredictionMarket is Test {
    PredictionMarket public market;
    MockUSDC public usdc;
    address admin = makeAddr("admin");
    address user1 = makeAddr("user1");
    address user2 = makeAddr("user2");
    address user3 = makeAddr("user3");

    function setUp() public {
        usdc = new MockUSDC();
        market = new PredictionMarket(admin, address(usdc));

        usdc.mint(user1, 10000e6);
        usdc.mint(user2, 10000e6);
        usdc.mint(user3, 10000e6);
    }
}