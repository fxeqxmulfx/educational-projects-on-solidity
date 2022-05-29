// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./SafeMath.sol";

contract BankDeposit {
    using SafeMath for uint256;
    mapping(address => uint256) public userDeposit;
    mapping(address => uint256) public balance;
    mapping(address => uint256) public time;
    mapping(address => uint256) public percentWithdraw;
    mapping(address => uint256) public allPercentWithdraw;
    uint256 public stepTime = 0.05 hours;

    event Invest(address investor, uint256 amount);
    event Withdraw(address investor, uint256 amount);

    modifier userExist() {
        require(balance[msg.sender] > 0, "Client not found");
        _;
    }

    modifier checkTime() {
        require(
            block.timestamp >= time[msg.sender].add(stepTime),
            "The payout request is too fast"
        );
        _;
    }

    function bankAccount() public payable {
        require(msg.value > 0.001 ether);
    }

    function collectPercent() public userExist checkTime {
        if (balance[msg.sender].mul(2) <= allPercentWithdraw[msg.sender]) {
            balance[msg.sender] = 0;
            time[msg.sender] = 0;
            percentWithdraw[msg.sender] = 0;
        } else {
            uint256 payout = payoutAmount();
            percentWithdraw[msg.sender] = percentWithdraw[msg.sender].add(
                payout
            );
            allPercentWithdraw[msg.sender] = allPercentWithdraw[msg.sender].add(
                payout
            );
            payable(msg.sender).transfer(payout);
            emit Withdraw(msg.sender, payout);
        }
    }

    function deposit() public payable {
        if (msg.value > 0) {
            if (
                balance[msg.sender] > 0 &&
                block.timestamp > time[msg.sender].add(stepTime)
            ) {
                collectPercent();
                percentWithdraw[msg.sender] = 0;
            }
            balance[msg.sender] = balance[msg.sender].add(msg.value);
            time[msg.sender] = block.timestamp;
            emit Invest(msg.sender, msg.value);
        }
    }

    function percentRate() public view returns (uint256) {
        if (balance[msg.sender] >= 30 ether) {
            return 9;
        }
        if (balance[msg.sender] >= 20 ether) {
            return 8;
        }
        if (balance[msg.sender] > 10 ether) {
            return 7;
        }
        return 5;
    }

    function payoutAmount() public view returns (uint256) {
        uint256 percent = percentRate();
        uint256 different = block.timestamp.sub(time[msg.sender]).div(stepTime);
        uint256 rate = balance[msg.sender].div(100).mul(percent);
        return rate.mul(different).sub(percentWithdraw[msg.sender]);
    }

    function returnDeposite() public {
        uint256 withdrawalAmount = balance[msg.sender];
        balance[msg.sender] = 0;
        time[msg.sender] = 0;
        percentWithdraw[msg.sender] = 0;
        payable(msg.sender).transfer(withdrawalAmount);
    }
}
