
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import "../src/ERC20.sol";
import "forge-std/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Univ2Test is Test {
    TokenTransfer testContract;

    // creates the contract and deploy it in a simulated environment
    // note that this executes the constructor() method.
    function setUp() public {
        testContract = new TokenTransfer();
    }

    
    function testDeploy() public {
        assertTrue(address(executioner) != address(0)); //In Ethereum, a contract is considered successfully deployed if it has an address that is not the zero address.
    }   
    
    function testTransferCheck() public {
        // Declare the test context
        address token = address(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2); // WETH https://etherscan.io/token/0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2hk
        address recipient = address(0xFD223351aa0Bca26D2C81f949e07d57448B132E9); // some random address
        uint256 testBalance = 1000000000000000000; // 1 ETH
        uint256 swapAmount = 100000000000000000; // 0.1 ETH

        // address(this) --> address of the test account
        // you don't need to setup a test account, the test contract will run with a random account
        // you can access the address of the test account with address(this)
        // cheatcode for dealing balance of a token into an address, which in this case is dealing x amount of Token to the test contract account
        deal(token, address(this), testBalance);

        // you can use the console to print out the balance of the test account
        // just import "forge-std/console.sol" in your tests
        // you can also import "forge-std/console.sol" into your contracts to print stuff out
        // but make sure to remove it before deploying since it's not needed in production

        console.log(
            "Initial Sender Balance: %s Recipeient Balance:",
            IERC20(token).balanceOf(address(this)),
            IERC20(token).balanceOf(recipient)
        );

        // Ideally i want to call something like this:
        testContract.transfer(IERC20(token), address(this), recipient, swapAmount);

        console.log(
            "Final Sender Balance: %s Recipeient Balance:",
            IERC20(token).balanceOf(address(this)),
            IERC20(token).balanceOf(recipient)
        );

        // you can use the assert functions to check if the test passed or failed
        assertEq(IERC20(token).balanceOf(address(this)), testBalance - swapAmount);
    
    }
}
