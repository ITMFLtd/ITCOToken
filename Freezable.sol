pragma solidity ^0.5.2;

import "FreezerRole.sol";

contract Freezable is FreezerRole {
    event Freeze(address account);
    event Unfreeze(address account);

    mapping (address => bool) private _frozen;

    /**
     * @return true if the contract is paused, false otherwise.
     */
    function isFrozen(address account) public view returns (bool) {
        return _frozen[account];
    }

    /**
     * @dev Modifier to make a function callable only when the contract is not paused.
     */
    modifier whenNotFrozen() {
        require(!_frozen[msg.sender]);
        _;
    }

    modifier whenNotFrozenTransfer(address to) {
        require(!_frozen[to]);
        require(!_frozen[msg.sender]);
        _;
    }

    modifier whenNotFrozenTransferFrom(address to, address from) {
        require(!_frozen[to]);
        require(!_frozen[from]);
        require(!_frozen[msg.sender]);
        _;
    }

    /**
     * @dev called by the owner to pause, triggers stopped state
     */
    function freeze(address account) public onlyFreezer {
        _frozen[account] = true;
        emit Freeze(account);
    }

    /**
     * @dev called by the owner to unpause, returns to normal state
     */
    function unfreeze(address account) public onlyFreezer {
        _frozen[account] = false;
        emit Unfreeze(account);
    }
}
