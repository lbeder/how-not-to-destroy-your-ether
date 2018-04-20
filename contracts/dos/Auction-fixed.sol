pragma solidity 0.4.21;

import "./SafeMath.sol";


contract Auction {
    using SafeMath for uint256;

    address public currentLeader;
    uint256 public highestBid;
    mapping(address => uint256) public refunds;

    function bid() public payable {
        require(msg.value > highestBid);

        refunds[currentLeader] = refunds[currentLeader].add(highestBid);

        currentLeader = msg.sender;
        highestBid = msg.value;
    }

    function withdraw() public {
        uint256 refund = refunds[msg.sender];
        require(refund > 0);

        refunds[msg.sender] = 0;

        msg.sender.transfer(refund);
    }
}
