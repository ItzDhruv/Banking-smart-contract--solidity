// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract banking{
    mapping(address =>uint256) public Balance;
    address payable owner;
    constructor() {
        owner = payable(msg.sender);
    }

    function deposite() public payable{
        require(msg.value>0,"Amout must be greter than zero");
        Balance[msg.sender]+=msg.value;
    }

    function withdraw(uint256 amount) public payable{
        require(Balance[msg.sender]>=amount,"NOt enough money in your account");
        require(msg.sender==owner,"only owner can withdraw funds");
        require(msg.value>0,"withdraw amount should be greater than 0");
        payable(msg.sender).transfer(amount);
        Balance[msg.sender]-=amount;
    }

    function transfer(address Reciver , uint amount) public  {
        require(Balance[msg.sender]>=amount,"Insufficient Ammount");
        require(amount>0,"transfer amount should be greater than 0");
        Balance[msg.sender]-=amount;
        Balance[Reciver]+=amount;
    }

    function getBalance(address user) public view returns(uint balance){
        return Balance[user];
    }

    function grantAccess(address payable user) public payable  {
        require(msg.sender==owner,"only owner can access grant");
        user=owner;
    }

    function rewakeAccess(address payable user) public{
        require(msg.sender==owner,"Only qwner can rewake access");
        require(msg.sender==owner,"Only qwner can rewake access");
        owner=payable (user);
    }

    // function Destroy() public{
    //     require(msg.sender==owner,"Only owner can destroy contract");
    //     selfdestruct(owner);
    // }
}