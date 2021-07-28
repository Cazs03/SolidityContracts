pragma solidity ^0.4.18;

interface Objetivo {
	function totalSupply() external view returns (uint256);

	function deposit() public payable;

	function withdraw(uint256 wad) public;
}

contract Exploit {
	mapping(address => uint256) public balanceOf;
	mapping(address => mapping(address => uint256)) public allowance;
	event Deposit(address indexed dst, uint256 wad);

	uint8 public intento = 0;
	uint8 public callbackIntento = 0;

	//Objetivo victima = Objetivo(0xc47b079b0e1F7bc77321efF5490E50b14b003d38);
	//address addressVictima = 0xc47b079b0e1F7bc77321efF5490E50b14b003d38;

	address public reciever;

	//address victima = 0xDDE76953CfB64E1ffBc2a48A7bb96e6F7D1EbC99;

	/*function deposit() public payable {
		balanceOf[msg.sender] += msg.value;
		Deposit(msg.sender, msg.value);
	}*/

	/*function getTotalSupply() public view returns (uint256) {
		//uint256 number = totalSupplyFromVictim.totalSupply();
		return number;
	}*/

	// EtherStore public etherStore;

	/*constructor(address _etherStoreAddres) public {
        etherStore = EtherStore(_etherStoreAddress);
    }*/

	/*() public {
		//revert();
	}*/

	/*function getBalance() public view returns (uint256) {
        	uint256 number = direccion.retrieve();
		uint256 balance = direccion.balanceOf[addressVictim];
		return balance;
	}*/

	//fallback() external payable  {  }
	//receive () external payable  {  }

	function() public payable {
		callbackIntento = callbackIntento + 1;
	}

	function attack(address _reciever) external payable {
		reciever = _reciever;
		//----------------------------Pruebas
		intento = intento + 1;

		//<--- FUNCIONA!!!!!!!!! ---------------------------------->
		//victima.deposit.value(msg.value)();
		//----------------------------------------------------/////

		//Call 0 <<--------------
		//reciever.call.value( msg.value)();

		//Call 0.1 <<--------------
		Objetivo victima = Objetivo(reciever);
		victima.deposit.value(msg.value)();

		//Call 1 <<--------------
		//bytes memory payload1= abi.encodeWithSignature("deposit()", msg.value);
		//reciever.call(payload1)();

		//Call 2 <<--------------
		/*reciever.call(
			abi.encodeWithSelector(bytes4(keccak256("deposit()")), msg.value)
		)();*/

		//Call 3 <<--------------
		//reciever.call(bytes4(keccak256("deposit()")), msg.value)();

		//Call 4 <<--------------
		///reciever.deposit(msg.value)();

		//Call 5 <<--------------
		//receiver.call.value(msg.value).gas(6721975)();

		//victima.deposit.value(msg.value);

		//victima.deposit.value(msg.value);

		//victima.deposit.value(1 ether)();

		//bytes memory payload = abi.encodeWithSignature("deposit()", msg.value);
		//addressVictima.call(payload);

		//addressVictima.call{gas: 1000000}(bytes4(sha3("deposit()")));

		//victima.deposit{value: msg.value, gas: 5000}("deposit");

		//IFoo(addr).foo{value: msg.value, gas: 5000}("call foo", 123)

		//addressVictima.call(abi.encodeWithSignature("deposit())", msg));

		//victima.deposit()();
	}

	function getRetrieve() public view returns (uint256) {
		return intento;
	}

	function getRetrieveCallback() public view returns (uint256) {
		return callbackIntento;
	}

	function getReciever() public view returns (address) {
		return reciever;
	}
}
