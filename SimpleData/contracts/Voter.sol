// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Voter {
    struct Candidate {
        uint256 id;
        string name;
        uint256 totalVotes;
    }

    mapping(address => bool) private voters;

    mapping(uint256 => Candidate) public candidates;

    uint256 private count;

    event votedEvent(uint256 indexed candidateId);

    function addCandidate(string memory newName) public {
        count++;
        candidates[count] = Candidate(count, newName, 0);
    }

    function vote(uint256 candidateId) public {
        require(!voters[msg.sender]);
        require(candidateId > 0 && candidateId <= count);
        voters[msg.sender] = true;
        candidates[candidateId].totalVotes++;
        emit votedEvent(candidateId);
    }
}
