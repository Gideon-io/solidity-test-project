
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {Test} from "forge-std/Test.sol";
import 'src/ERC20.sol';
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import 'src/testToken.sol';

contract ERC20test is Test{
    ERC20 public tokenTransfer;
    IERC20 public token;

    address public sender;
    address public recipient;
    uint public amount = 1000;
    uint constant SENDER_PRIVATE_KEY = 123;

    function setUp() public {

        sender = vm.addr(SENDER_PRIVATE_KEY);   
        recipient = address(2);
        // Deploy the ERC20 token contract
        token = new ERC20("testToken", "TEST");

        // Mint some tokens for the sender
        token.mint(sender, amount);

        // Create a new instance of TokenTransfer
        tokenTransfer = new TokenTransfer(address(token), sender, recipient, amount);
    }

    function testTransfer_check() public {
        // Call the transfer_check function
        tokenTransfer.transfer_check();

        // Assert that the transfer was successful
        assertEq(token.balanceOf(recipient), amount, "Incorrect recipient balance");
    }
}
 
