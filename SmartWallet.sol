// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SmartWallet {
    address public owner;
    mapping(address => bool) public authorized;

    event Deposit(address indexed sender, uint amount);
    event Withdraw(address indexed recipient, uint amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(address payable _to, uint _amount, uint _code) public onlyOwner {
        require(verify2FA(_code), "2FA failed");
        require(address(this).balance >= _amount, "Insufficient balance");
        _to.transfer(_amount);
        emit Withdraw(_to, _amount);
    }

    function verify2FA(uint code) private view returns (bool) {
        // Mock 2FA for demo: In production, integrate with a backend for real verification
        return code == 123456;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}
