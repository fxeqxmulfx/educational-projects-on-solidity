// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Split {
    address public owner;
    mapping(address => uint256) public balances;
    event Sent(
        address from,
        address receiver1,
        address receiver2,
        address receiver3,
        uint256 amount
    );

    constructor() {
        owner = msg.sender;
    }

    function coin(address receiver, uint256 amount) public {
        require(msg.sender == owner, "Access denied");
        require(amount < 1e60, "Overflow");
        balances[receiver] += amount;
    }

    function send(
        address receiver1,
        address receiver2,
        address receiver3,
        uint256 amount
    ) public {
        require(amount <= balances[msg.sender], "Insufficient funds");
        balances[msg.sender] -= amount;
        balances[receiver1] += amount / 3;
        balances[receiver2] += amount / 3;
        balances[receiver3] += amount / 3;
        emit Sent(msg.sender, receiver1, receiver2, receiver3, amount);
    }
}
