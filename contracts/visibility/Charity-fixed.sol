pragma solidity 0.4.21;


contract Charity {
    address public owner;

    event Donated(address indexed donor, uint256 value);
    event Withdrawn(uint256 value);

    modifier onlyOwner {
        require(msg.sender == owner);

        _;
    }

    function Charity() public {
        setOwner(msg.sender);
    }

    function() public payable {
        if (msg.value > 0) {
            emit Donated(msg.sender, msg.value);
        }
    }

    function withdraw(address _to) public onlyOwner {
        require(_to != address(0));

        uint256 balance = address(this).balance;
        _to.transfer(balance);

        emit Withdrawn(balance);
    }

    function setOwner(address _owner) private {
        require(_owner != address(0));

        owner = _owner;
    }
}
