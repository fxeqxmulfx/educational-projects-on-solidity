// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract RLottery {
    struct Player {
        uint256 num;
    }
    mapping(uint256 => Player) public players;

    function getTickets(uint256 num) public payable {
        require(num <= 10, "10 players have already been registered!");
        players[num] = Player(num);
    }

    function winner()
        public
        view
        returns (string memory message, uint256 winnerNumber)
    {
        uint256 lenght = 10;
        uint256 randomNumber = (uint256(
            keccak256(abi.encodePacked(block.timestamp, msg.sender, lenght))
        ) % 9) + 1;
        uint256 index = randomNumber % 10;
        return ("Winner's number", index);
    }
}
