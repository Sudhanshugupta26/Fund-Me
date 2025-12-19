// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        // Before anything startbroadcast() => Not a Tx
        HelperConfig helperConfig = new HelperConfig();
        address ethUsdPriceFeed = helperConfig.activeNetworkConfig();

        // Only broadcast if running in actual script mode (not in tests)
        if (msg.sender != address(this)) {
            vm.startBroadcast();
        }

        FundMe fundMe = new FundMe(ethUsdPriceFeed);

        if (msg.sender != address(this)) {
            vm.stopBroadcast();
        }

        return fundMe;
    }
}
