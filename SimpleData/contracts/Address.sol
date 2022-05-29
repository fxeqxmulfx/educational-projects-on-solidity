// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Address {
    mapping(uint256 => address) addresses;

    uint256 count;

    function set(address userAddress) public {
        addresses[count] = userAddress;
        count++;
    }

    function get(address userAddress) public view returns (uint256 index) {
        for (uint256 i = 0; i <= count; i++) {
            if (addresses[i] == userAddress) {
                return i;
            }
        }
        return 0;
    }

    function getAll() public view returns (address[] memory users) {
        address[] memory all = new address[](count);
        for (uint256 i = 0; i <= count; i++) {
            all[i] = addresses[i];
        }
        return all;
    }
}
