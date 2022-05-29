// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Dice {
    address public manager;
    address payable[] public players;

    modifier onlyManager() {
        require(manager == msg.sender, "No access");
        _;
    }

    constructor() {
        manager = msg.sender;
    }

    function ceo() public {
        manager = msg.sender;
    }

    function enter() public payable {
        require(msg.value > 0.001 ether, "The bid is too small!");
        players.push(payable(msg.sender));
    }

    function getRandomNumber(uint256 seed)
        private
        view
        returns (uint256 randomNumber)
    {
        return
            (uint256(
                keccak256(abi.encodePacked(block.timestamp, msg.sender, seed))
            ) % 10) + 2;
    }

    function winner()
        public
        payable
        restricted
        returns (
            string memory,
            uint256,
            uint256
        )
    {
        uint256 playerOne = getRandomNumber(0);
        uint256 playerTwo = getRandomNumber(1);
        if (playerOne > playerTwo) {
            players[0].transfer(address(this).balance);
            return ("The first one won", playerOne, playerTwo);
        }
        if (playerTwo > playerOne) {
            players[1].transfer(address(this).balance);
            return ("The second one won", playerOne, playerTwo);
        }
        return ("Draw", playerOne, playerTwo);
    }

    modifier restricted() {
        require(msg.sender == manager, "No access");
        _;
    }
}
