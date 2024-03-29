pragma solidity ^0.5.2;

import "../Roles.sol";
import "contracts/access/AdminRole.sol";

/**
 * @dev MinterRole has been modified from its original openzeppelin source to
 * allow for more detailed permissions
 */
contract MinterRole is AdminRole {
    using Roles for Roles.Role;

    event MinterAdded(address indexed account);
    event MinterRemoved(address indexed account);

    Roles.Role private _minters;

    constructor () internal {
        _addMinter(msg.sender);
    }

    modifier onlyMinter() {
        require(isMinter(msg.sender));
        _;
    }

    function isMinter(address account) public view returns (bool) {
        return _minters.has(account);
    }

    /**
     * @dev Function has been modified from original library to only allow
     * accounts with admin role to add a minter
     */
    function addMinter(address account) public onlyAdmin {
        _addMinter(account);
    }

    /**
     * @dev Admin only function to strip someone of minter role. This function
     * was not present in the original library
     * @param account The account to be removed as a minter
     */
    function removeMinter(address account) public onlyAdmin {
        _removeMinter(account);
    }

    function renounceMinter() public {
        _removeMinter(msg.sender);
    }

    function _addMinter(address account) internal {
        _minters.add(account);
        emit MinterAdded(account);
    }

    function _removeMinter(address account) internal {
        _minters.remove(account);
        emit MinterRemoved(account);
    }
}
