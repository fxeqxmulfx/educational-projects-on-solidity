// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./DragonFarm.sol";

contract DragonForge is DragonFarm {
    function reforge(
        string memory name,
        uint256 id,
        uint256 food
    ) public payable {
        require(msg.value > 0, "Pay for the food");
        uint256 brains = uint256(keccak256((abi.encode(food)))) % (10**16);
        uint256 newDna = (id + brains) / 2;
        dragons.push(Dragon(id, name, newDna));
    }
}
