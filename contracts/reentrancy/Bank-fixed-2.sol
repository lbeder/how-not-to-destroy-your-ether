pragma solidity 0.4.24;

import "./SafeMath.sol";


contract Bank {
    using SafeMath for uint256;

    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] = balances[msg.sender].add(msg.value);
    }

    function withdraw() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0);

        balances[msg.sender] = 0;

        msg.sender.transfer(amount);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
