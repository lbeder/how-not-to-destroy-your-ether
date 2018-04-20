pragma solidity 0.4.21;


contract Greeter {
    string public greeting;
    address public owner;

    modifier onlyOwner {
        require(msg.sender == owner);

        _;
    }

    function Greeter(string _greeting) public {
        owner = msg.sender;

        setGreeting(_greeting);
    }

    function setGreeting(string _greeting) public onlyOwner {
        greeting = _greeting;
    }
}
