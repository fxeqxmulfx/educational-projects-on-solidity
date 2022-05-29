// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Factorial {
    function getFactorial(uint256 n) public pure returns (uint256 result) {
        uint256 f = 1;
        for (uint256 i = 1; i <= n; i++) {
            f *= i;
        }
        return f;
    }
}
