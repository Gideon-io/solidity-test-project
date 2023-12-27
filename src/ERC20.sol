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
pragma solidity ^0.8.13; //define the solidity version

import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; //shortened via the remappings.txt

contract TokenTransfer {
    IERC20 public token; //public state variable token of type IERC20 declared
    address public sender; //public state variable sender of type address declared
    address public recipient;
    uint public amount;
    //The constructor is executed when the contract is deployed. 
    //It initializes the state variables with the provided values.
    constructor(address _token, address _sender, address _recipient, uint _amount) {
        token = IERC20(_token);
        sender = _sender;
        recipient = _recipient;
        amount = _amount;
    }
    //This function performs prior check to ensure the sender is an autorized sender and has sufficient balance. If it passes, it will be sent to the _safeTransfer function
    function transfer_check() public {
        require(msg.sender == sender, "Not authorized"); //checks if the caller is the authorized sender. require = if true, it will continue the flow, if error, it will stop and show the error message
        require(token.balanceOf(sender) >= amount, "Insufficient balance"); //checks if the sender has a sufficient balance of tokens
        require(token.approve(sender,amount), "Transfer is not approved");
        //If the checks pass, it calls the _safeTransfer function to execute the actual token transfer.
        _safeTransfer(token, sender, recipient, amount);
    }
    //This is a private helper function for performing the actual token transfer.
    function _safeTransfer(
        IERC20 token, //It takes the ERC-20 token instance, sender, recipient, and amount as parameters.
        address sender,
        address recipient,
        uint amount
    ) private {
        //It calls the transferFrom function on the ERC-20 token contract to transfer tokens from the sender to the recipient.
        bool sent = token.transferFrom(sender, recipient, amount);
        //It includes a require statement to check if the transfer was successful. 
        //If not, it raises an error indicating that the token transfer failed.
        require(sent, "Token transfer failed");
    }
}