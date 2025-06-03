// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";

contract InteractionTest is Test {
    FundMe fundMe;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    uint256 constant GAS_PRICE = 1;


    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
         fundMe = deployFundMe.run();
         vm.deal(USER, STARTING_BALANCE);

        //console.log("FundMe balance after funding:", address(fundMe).balance);
    }

    function testUserCanFundInteractions() public {
        FundFundMe fundFundMe = new FundFundMe();
        console.log("USER balance before funding:", USER.balance);
        //vm.prank(USER);
        fundFundMe.fundFundMe(address(fundMe));
        console.log("User balance after funding:", address(USER).balance);
        //assert(address(fundMe).balance == 0.01 ether);

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        //vm.prank(fundMe.getOwner());
        withdrawFundMe.withdrawFundMe(address(fundMe));
        console.log("FundMe balance after withdrawal:", address(fundMe).balance);
        assert(address(fundMe).balance == 0);

    }
}