// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

contract Escrow {
    address agent;
    mapping(address => uint256) public deposits;
    
    modifier onlyAgent(){
        require(msg.sender == agent);
        _;
    }
    
    constructor() public{
        agent = msg.sender;
    }
    
    function deposit(address payee)public onlyAgent payable{
        require(msg.sender == agent, "Agent only");
        uint256 amount = msg.value;
        deposits[payee] = deposits[payee] + amount;
    }
    
    function balenceOf() external view returns (uint){
        return address(this).balance;
    }
    
    
    function withdraw(address payable payee)public onlyAgent{
        uint256 payment = deposits[payee];
        deposits[payee] = 0;
        payee.transfer(payment);
    }
}