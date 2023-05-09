// SPDX-License-Identifier: UNLICENSED
import "hardhat/console.sol";

pragma solidity ^0.8.0;

contract Transactions {
    address owner;
    mapping (address => uint256) private balances;
    
    constructor() {
        owner = msg.sender;
    }
    
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero.");
        balances[msg.sender] += msg.value;
    }
    
    function withdraw(uint256 amount) public {
        require(msg.sender == owner, "Only the owner can withdraw funds.");
        require(amount > 0 && amount <= balances[msg.sender], "Invalid amount specified.");
        
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
    
    function getBalance(address account) public view returns (uint256) {
        require(msg.sender == owner || msg.sender == account, "Only account holders or the owner can view balances.");
        return balances[account];
    }
}
