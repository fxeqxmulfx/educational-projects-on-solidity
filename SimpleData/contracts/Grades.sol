// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Grades {
    struct Calc {
        uint256 amount;
        uint256 sum;
        uint256 average;
    }

    mapping(string => Calc) public results;

    function MyGrade(string memory title, uint256 grade) public {
        require(grade >= 1 && grade <= 5);
        results[title].amount++;
        results[title].sum += grade;
        results[title].average = uint256(
            results[title].sum / results[title].amount
        );
    }
}
