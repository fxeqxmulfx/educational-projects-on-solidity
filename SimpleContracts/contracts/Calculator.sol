// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Calculator {
    function getCalc(
        uint256 x,
        bytes32 oper,
        uint256 y
    ) public pure returns (uint256 result) {
        if (oper == "+") return x + y;
        if (oper == "-") return x - y;
        if (oper == "*") return x * y;
        if (oper == "/") return x / y;
        return 0;
    }
}
