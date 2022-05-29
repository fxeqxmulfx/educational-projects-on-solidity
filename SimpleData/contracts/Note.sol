// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Note {
    string public name;
    uint256 number;
    string public adress;

    function set(
        string memory newName,
        uint256 newNumber,
        string memory newAddress
    ) public {
        name = newName;
        number = newNumber;
        adress = newAddress;
    }

    function get()
        public
        view
        returns (
            string memory rName,
            uint256 rNumber,
            string memory rAddress
        )
    {
        return (name, number, adress);
    }
}
