pragma solidity ^0.5.2;

import "FreezerRole.sol";

/**
 * @author ITMF Ltd.
 * @title Freezable - Contract to allow accounts to be frozen
 */
contract Freezable is FreezerRole {
    event Freeze(address account);
    event Unfreeze(address account);

    mapping (address => bool) private _frozen;

    /**
     * @param account The account address to be checked
     * @return true if the account has been marked as frozen
     */
    function isFrozen(address account) public view returns (bool) {
        return _frozen[account];
    }

    /**
     * @dev Modifier to make a function callable only when the message sender
     * has not had their account frozen
     */
    modifier whenNotFrozen() {
        require(!_frozen[msg.sender]);
        _;
    }

    /**
     * @dev Modifier to make a function callable only when the message sender
     * and the account that they are sending to have not been frozen
     * @param to The target account for which tokens are being sent to during
     * a transfer
     */
    modifier whenNotFrozenTransfer(address to) {
        require(!_frozen[to]);
        require(!_frozen[msg.sender]);
        _;
    }

    /**
     * @dev Modifier to make a function callable only when the message sender,
     * the account that they are sending to, and the receiving account have not
     * been frozen
     * @param to The target account for which tokens are being sent to during
     * a transfer
     * @param from The source account for which tokens are being drawn from
     * during a transfer
     */
    modifier whenNotFrozenTransferFrom(address to, address from) {
        require(!_frozen[to]);
        require(!_frozen[from]);
        require(!_frozen[msg.sender]);
        _;
    }

    /**
     * @dev Called by a freezer to mark an account as frozen
     * @param account The account to be frozen
     */
    function freeze(address account) public onlyFreezer {
        _frozen[account] = true;
        emit Freeze(account);
    }

    /**
     * @dev Called by a freezer to mark an account as not frozen
     * @param account The account to be unfrozen
     */
    function unfreeze(address account) public onlyFreezer {
        _frozen[account] = false;
        emit Unfreeze(account);
    }
}
