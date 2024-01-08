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
import "forge-std/console.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol"; //shortened via the remappings.txt

contract TokenTransfer {

    constructor() {}
    //Commented out as you cant approve inside a contract function
    //0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
    /*
    function approval(IERC20 _token, address _spender, uint256 _value) public {
        bool approvalStatus = _token.approve(_spender, _value);
        console.log("Approved?: %s || Caller Contract address: %s", approvalStatus, _spender); 
        require(approvalStatus, "Not approved");
    }

    function allowanceCheck(IERC20 _token, address _owner, address _spender) view public {
        uint256 aBalance = _token.allowance(_owner, _spender);
        console.log("Allowance available: %s", aBalance);
    }
    **/

    //This function performs prior check to ensure the sender is an authorized sender and has sufficient balance. If it passes, it will be sent to the _safeTransfer function
    
    function transact(IERC20 _token, address _sender, address _recipient, uint256 _amount) public {
        
        require(msg.sender == _sender, "Not authorized"); 
        
        require(_token.balanceOf(_sender) >= _amount, "Insufficient balance");
        
        _safeTransfer(_token, _sender, _recipient, _amount); 
    }

    function _safeTransfer(IERC20 _token, address _sender, address _recipient, uint256 _amount) private {
        console.log("sender address: %s || recipient address: %s || amount: %s", _sender, _recipient, _amount);
        bool sent = _token.transferFrom(_sender, _recipient, _amount); //fails here
        console.log(sent); 
        require(sent, "Token transfer failed");
    }
    

}