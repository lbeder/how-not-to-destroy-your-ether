pragma solidity 0.4.24;


contract GenerousAttacker {
    address public target;

    constructor(address _target) public {
        target = _target;
    }

    function() public payable {
        selfdestruct(target);
    }
}
