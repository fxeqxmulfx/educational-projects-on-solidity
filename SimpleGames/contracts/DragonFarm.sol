// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract DragonFarm {
    event newDragon(uint256 id, string name, uint256 dna);
    struct Dragon {
        uint256 id;
        string name;
        uint256 dna;
    }
    Dragon[] public dragons;
    mapping(uint256 => address) dragonOwner;
    mapping(address => uint256) ownerDragons;

    function generateRandomData(string memory _str)
        private
        pure
        returns (uint256 randomValue)
    {
        return uint256(keccak256((abi.encode(_str)))) % (10**16);
    }

    function createDragon(string memory _name) public {
        uint256 dna = generateRandomData(_name);
        uint256 id = ownerDragons[msg.sender];
        dragons.push(Dragon(id, _name, dna));
        dragonOwner[id] = msg.sender;
        emit newDragon(id, _name, dna);
        ownerDragons[msg.sender];
    }
}
