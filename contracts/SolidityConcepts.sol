// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SolidityConcepts {
    uint public constant FIXED_VALUE = 100;
    address public immutable owner = msg.sender;
    uint public value = 50;

    function checkValue(uint _value) public pure returns (string memory) {
        if (_value > 100) {
            return "Value is greater than 100";
        } else if (_value == 100) {
            return "Value is exactly 100";
        } else if (_value < 100) {
            return ("Value is less than 100");
        }
    }

    function sumUpTo(uint _value) public pure returns (uint) {
        uint sum = 0;
        for (uint i = 1; i <= _value; i++) {
            sum += i;
        }
        return sum;
    }

    event ValueChanged(uint256 oldValue, uint256 newValue);

    function updateValue(uint newValue) public {
        uint oldValue = value;
        value = newValue;
        emit ValueChanged(oldValue, newValue);
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Not the contract owner");
        _;
    }

    function ownerFunction() public view onlyOwner returns (string memory) {
        return "Hello, Owner!";
    }

    receive() external payable {}

    function sendEther(address payable _addr) public payable {
        (bool sent, ) = _addr.call{value: msg.value}("");
        require(msg.value > 0, "Must send ether");
    }
    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
    function withDraw() public payable onlyOwner {
        (bool result, ) = owner.call{value: address(this).balance}("");
    }
}
