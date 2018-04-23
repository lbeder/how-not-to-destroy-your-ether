pragma solidity 0.4.21;


contract Auction {
    address public currentLeader;
    uint256 public highestBid;

    function Auction() public {
        currentLeader = msg.sender;
        highestBid = 0;
    }

    function bid() public payable {
        require(msg.value > highestBid);

        address prevCurrentLeader = currentLeader;
        uint256 prevHighestBid = highestBid;

        currentLeader = msg.sender;
        highestBid = msg.value;

        prevCurrentLeader.transfer(prevHighestBid);
    }
}
