pragma solidity 0.4.21;


contract Greeter {
    string public greeting;
    address public owner;

    event LogMessage(string message);

    modifier onlyOwner {
        require(msg.sender == owner);

        _;
    }

    function Greeter(string _greeting) public {
        owner = msg.sender;

        setGreeting(_greeting);
    }

    function() public {
        emit LogMessage("I've been called!");
    }

    function setGreeting(string _greeting) public onlyOwner {
        greeting = _greeting;
    }
}
