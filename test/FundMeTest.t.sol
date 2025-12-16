//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundme;

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundme = deployFundMe.run();
    }

    function testMinimumUsdIsFive() public {
        assertEq(fundme.MINIMUM_USD(), 5 * 10 ** 18);
        /*What it's used for:
            Compares two values and checks if they are equal
            If the values match, the test passes
            If the values don't match, the test fails and prints an error message showing both values */
    }

    function testOwnerIsMsgSender() public {
        console.log("Owner Address:", fundme.i_owner());
        console.log("Msg Sender Address:", msg.sender);
        assertEq(fundme.i_owner(), msg.sender);
    }

    function testPriceFeedVersionisAccurate() public {
        uint256 version = fundme.getVersion();
        console.log("Price Feed Version:", version);
        assertEq(version, 4);
    }
}
