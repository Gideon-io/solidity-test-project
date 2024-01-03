/**
Write a contract that allows caller to send x amounts of Token to a target address. 
Caller calls contract function "Transact" with parameters:
- target address
- amount of token to send

The contract should check if the caller has enough balance to do so. If yes, it should send the token to the target address. If not, it should revert the transaction.
The contract should also have a function "getBalance" that returns the balance of the caller for the token.

Key notes: 
- use the IERC20 token interface (learn how to use interfaces) to interface with the Token. 
- use the transferFrom function of the token contract to send the token
- use the balanceOf function of the token contract to get the balance of the caller
- use the allowance function of the token contract to check if the caller has enough allowance to send the token

Before a transferFrom can be done, the caller must first approve the contract to spend the token on behalf of the caller.
- use the approve function of the token contract to approve the contract to spend the token on behalf of the caller
 */


//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19; //define the solidity version

import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; //shortened via the remappings.txt

contract TokenTransfer {

    constructor() {}

    //This function performs prior check to ensure the sender is an autorized sender and has sufficient balance. If it passes, it will be sent to the _safeTransfer function

    function transfer(IERC20 _token, address _sender, address _recipient, uint256 _amount) public {
        require(msg.sender == _sender, "Not authorized"); 
        require(_token.balanceOf(_sender) >= _amount, "Insufficient balance"); 
        require(_token.approve(_sender, _amount), "Transfer is not approved"); 
        _safeTransfer(_token, _sender, _recipient, _amount); 
    }

    function _safeTransfer(IERC20 _token, address _sender, address _recipient, uint256 _amount) private {
        bool sent = _token.transferFrom(_sender, _recipient, _amount); 
        require(sent, "Token transfer failed");
    }
    
}