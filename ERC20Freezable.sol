pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "Freezable.sol";

/**
 * @author ITMF Ltd.
 * @title ERC20Freezable - Contract overrides standard ERC20 function behavior
 * to implement freezable accounts
 */
contract ERC20Freezable is ERC20, Freezable {

    function transfer(address to, uint256 value) public whenNotFrozenTransfer(to) returns (bool) {
        return super.transfer(to, value);
    }

    function transferFrom(address from, address to, uint256 value) public whenNotFrozenTransferFrom(to, from) returns (bool) {
        return super.transferFrom(from, to, value);
    }

    function approve(address spender, uint256 value) public whenNotFrozen returns (bool) {
        return super.approve(spender, value);
    }

    function increaseAllowance(address spender, uint addedValue) public whenNotFrozen returns (bool success) {
        return super.increaseAllowance(spender, addedValue);
    }

    function decreaseAllowance(address spender, uint subtractedValue) public whenNotFrozen returns (bool success) {
        return super.decreaseAllowance(spender, subtractedValue);
    }

}
