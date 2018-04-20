pragma solidity 0.4.21;

import "./SafeMath.sol";


contract Asset {
    using SafeMath for uint256;

    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner);

        _;
    }

    function Asset() public {
        owner = msg.sender;
    }

    function() public payable {
    }

    function withdraw() public payable onlyOwner {
        owner.transfer(address(this).balance);
    }

    function outbid() public payable {
        uint256 balance = address(this).balance;

        if (msg.value > balance) {
            owner = msg.sender;

            msg.sender.transfer(balance.add(msg.value));
        }
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
