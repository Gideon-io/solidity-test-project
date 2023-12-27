// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {Test} from "forge-std/Test.sol";
import 'src/Calculator.sol';

contract CalcTest is Test {
    Calculator calc;

    function setUp() public {
        calc = new Calculator();
    }

    function testInitialValue() public {
        uint expected = 5;
        assertEq(calc.get(), expected, "Initial value set for contract is 5");
    }

    function testAdd() public {
        calc.add(5);
        uint expected = 10;
        assertEq(calc.get(), expected, "5 + 5 is 10");
    }

    function testSubtract() public {
        calc.subtract(3);
        uint expected = 2;
        assertEq(calc.get(), expected, "5 - 3 is 2");
    }

    function testMultiply() public {
        calc.multiple(2);
        uint expected = 10;
        assertEq(calc.get(), expected, "5 times 2 is 10");
        emit log_named_uint("The value is ", expected);
    }

}