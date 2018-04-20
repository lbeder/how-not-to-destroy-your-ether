pragma solidity 0.4.21;


contract Auction {
    address public currentLeader;
    uint256 public highestBid;

    function bid() public payable {
        require(msg.value > highestBid);

        currentLeader.transfer(highestBid);

        currentLeader = msg.sender;
        highestBid = msg.value;
    }
}
