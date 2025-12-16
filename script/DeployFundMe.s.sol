// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        // Only broadcast if running in actual script mode (not in tests)
        if (msg.sender != address(this)) {
            vm.startBroadcast();
        }

        FundMe fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);

        if (msg.sender != address(this)) {
            vm.stopBroadcast();
        }

        return fundMe;
    }
}
