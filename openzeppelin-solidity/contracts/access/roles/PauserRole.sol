pragma solidity ^0.5.2;

import "../Roles.sol";
import "contracts/access/AdminRole.sol";

/**
 * @dev PauserRole has been modified from its original openzeppelin source to
 * allow for more detailed permissions
 */
contract PauserRole is AdminRole {
    using Roles for Roles.Role;

    event PauserAdded(address indexed account);
    event PauserRemoved(address indexed account);

    Roles.Role private _pausers;

    constructor () internal {
        _addPauser(msg.sender);
    }

    modifier onlyPauser() {
        require(isPauser(msg.sender));
        _;
    }

    function isPauser(address account) public view returns (bool) {
        return _pausers.has(account);
    }

    /**
     * @dev Function has been modified from original library to only allow
     * accounts with admin role to add a pauser
     */
    function addPauser(address account) public onlyAdmin {
        _addPauser(account);
    }

    /**
     * @dev Admin only function to strip someone of pauser role. This function
     * was not present in the original library
     * @param account The account to be removed as a pauser
     */
    function removeMinter(address account) public onlyAdmin {
        _removePauser(account);
    }

    function renouncePauser() public {
        _removePauser(msg.sender);
    }

    function _addPauser(address account) internal {
        _pausers.add(account);
        emit PauserAdded(account);
    }

    function _removePauser(address account) internal {
        _pausers.remove(account);
        emit PauserRemoved(account);
    }
}
