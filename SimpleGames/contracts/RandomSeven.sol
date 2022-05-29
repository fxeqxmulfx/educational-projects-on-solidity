// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract RandomSeven {
    function random(uint256 x) public pure returns (string memory result) {
        uint256 n;
        uint256 masRand;
        x = x * 1103515245 + 12345;
        n = (x / 65536) % 32768;
        for (uint256 i = 1; i < 5; i++) {
            masRand = ((n % (10**i)) / (10**(i - 1)));
            if (masRand == 7) {
                return "Winner";
            }
        }
        return "Loser";
    }
}
