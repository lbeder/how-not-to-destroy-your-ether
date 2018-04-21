pragma solidity 0.4.21;

import "./SafeMath.sol";


contract Reward {
    using SafeMath for uint256;

    address public owner;

    mapping(address => uint256) public rewards;

    event Awarded(address indexed winner, uint256 value);

    modifier onlyOwner {
        require(msg.sender == owner);

        _;
    }

    function Reward() public {
        owner = msg.sender;
    }

    function setReward(address _winner, uint256 _reward) external onlyOwner {
        rewards[_winner] = _reward;
    }

    function claimReward(uint256 _reward) public {
        rewards[msg.sender] = rewards[msg.sender].sub(_reward);

        emit Awarded(msg.sender, _reward);
    }
}
