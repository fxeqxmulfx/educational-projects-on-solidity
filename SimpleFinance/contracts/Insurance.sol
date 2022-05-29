// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Insurance {
    address payable public hospital;
    address payable public insurer;

    struct Record {
        address addr;
        uint256 id;
        string name;
        string date;
        uint256 price;
        bool isValue;
        uint256 signatureCount;
        mapping(address => uint256) signatures;
    }

    modifier signOnly() {
        require(msg.sender == hospital || msg.sender == insurer);
        _;
    }

    constructor() {
        hospital = payable(0x1158E4032F4d183bFF14d452288AC7043aDacFF2);
        insurer = payable(0x41644D7eE8A08D76a6D17a0fB160A70c2D11953F);
    }

    mapping(uint256 => Record) public allRecord;

    uint256[] public recordsArr;

    event recordCreated(
        uint256 id,
        string testName,
        string date,
        uint256 price
    );

    event recordSigned(uint256 id, string testName, string date, uint256 price);

    function newRecord(
        uint256 id,
        string memory name,
        string memory date,
        uint256 price
    ) public {
        Record storage record = allRecord[id];
        require(!allRecord[id].isValue);
        record.addr = msg.sender;
        record.id = id;
        record.name = name;
        record.date = date;
        record.price = price;
        record.isValue = true;
        record.signatureCount = 0;
        recordsArr.push(id);
        emit recordCreated(id, name, date, price);
    }

    function signRecord(uint256 id) public payable signOnly {
        Record storage record = allRecord[id];
        require(record.signatures[msg.sender] != 1);
        record.signatures[msg.sender] = 1;
        record.signatureCount++;
        emit recordSigned(record.id, record.name, record.date, record.price);
        if (record.signatureCount == 2) {
            hospital.transfer(address(this).balance);
        }
    }
}
