pragma solidity 0.4.24;


contract Reward {
    address public owner;

    mapping(address => uint256) public rewards;

    event Awarded(address indexed winner, uint256 value);

    modifier onlyOwner {
        require(msg.sender == owner);

        _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function setReward(address _winner, uint256 _reward) external onlyOwner {
        rewards[_winner] = _reward;
    }

    function claimReward(uint256 _reward) public {
        require(rewards[msg.sender] >= _reward);

        rewards[msg.sender] -= _reward;

        emit Awarded(msg.sender, _reward);
    }
}
