// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Transaction {
    address public owner;
    mapping(address => uint256) public balances;
    event Sent(address from, address to, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    function coin(address receiver, uint256 amount) public {
        require(msg.sender == owner, "Access denied");
        require(amount < 1e60, "Overflow");
        balances[receiver] += amount;
    }

    function send(address receiver, uint256 amount) public {
        require(amount <= balances[msg.sender], "Insufficient funds");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}
