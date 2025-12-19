//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundme;

    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundme = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
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

    function testFundFailsWithoutEnoughETH() public {
        vm.expectRevert(); // Next line should revert
        fundme.fund();
    }

    function testFundUpdatesFundedDataStructure() public {
        vm.prank(USER); // The next tx will be sent by USER
        fundme.fund{value: SEND_VALUE}();

        uint256 amountFunded = fundme.getAddressToAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUE);
    }
}
