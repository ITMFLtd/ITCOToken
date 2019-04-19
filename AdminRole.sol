pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/access/Roles.sol";

/**
 * @author ITMF Ltd.
 * @title AdminRole - Permissions/Access control role who can assign roles
 */
contract AdminRole {
    using Roles for Roles.Role;

    event AdminAdded(address indexed account);
    event AdminRemoved(address indexed account);

    Roles.Role private _admins;

    constructor () internal {
        _addAdmin(msg.sender);
    }

    /**
     * @dev Modifier to only allow function to be called by admins
     */
    modifier onlyAdmin() {
        require(isAdmin(msg.sender));
        _;
    }

    /**
     * @param account The account to check for admin role
     * @return true if account has admin role
     */
    function isAdmin(address account) public view returns (bool) {
        return _admins.has(account);
    }

    /**
     * @dev Public function to add an admin
     * @param account The account to be added as an admin
     */
    function addAdmin(address account) public onlyAdmin {
        _addAdmin(account);
    }

    /**
     * @dev Renounce admin role. Message sender will no longer be admin
     */
    function renounceAdmin() public {
        _removeAdmin(msg.sender);
    }

    /**
     * @dev Internal function to implement adding an admin
     * @param account The account to be added as an admin
     */
    function _addAdmin(address account) internal {
        _admins.add(account);
        emit AdminAdded(account);
    }

    /**
     * @dev Internal function to implement removing/renouncing admin role
     * @param account The account to be removed from being an admin
     */
    function _removeAdmin(address account) internal {
        _admins.remove(account);
        emit AdminRemoved(account);
    }
}
