pragma solidity 0.4.21;


contract Greeter {
    string public greeting;
    address public owner;

    event Donated(uint256 value);

    modifier onlyOwner {
        require(msg.sender == owner);

        _;
    }

    function Greeter(string _greeting) public {
        owner = msg.sender;

        setGreeting(_greeting);
    }

    function() external payable {
        donate();
    }

    function troll() external {
        // No transaction with non-zero msg.value can't reach this...
    }

    function donate() public payable {
        if (msg.value > 0) {
            emit Donated(msg.value);
        }
    }

    function setGreeting(string _greeting) public onlyOwner {
        greeting = _greeting;
    }
}
