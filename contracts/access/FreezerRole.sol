pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/access/Roles.sol";
import "./AdminRole.sol";

/**
* @author ITMF Ltd.
* @title FreezerRole - Access for who can freeze/unfreeze accounts
*/
contract FreezerRole is AdminRole {
    using Roles for Roles.Role;

    event FreezerAdded(address indexed account);
    event FreezerRemoved(address indexed account);

    Roles.Role private _freezers;

    constructor () internal {
        _addFreezer(msg.sender);
    }

    /**
     * @dev Modifier to only allow action to be performed by a freezer
     */
    modifier onlyFreezer() {
        require(isFreezer(msg.sender));
        _;
    }

    /**
     * @param account The account to check for freezer role
     * @return true if account has freezer role
     */
    function isFreezer(address account) public view returns (bool) {
        return _freezers.has(account);
    }

    /**
     * @dev Public function for adding a freezer
     * @param account The account to be added as freezer
     */
    function addFreezer(address account) public onlyAdmin {
        _addFreezer(account);
    }

    /**
     * @dev Renounce freezer role. Message sender will no longer be freezer
     */
    function renounceFreezer() public {
        _removeFreezer(msg.sender);
    }

    /**
     * @dev Admin only function to strip someone of the freezer role
     * @param account The account to remove from freezer role
     */
    function removeFreezer(address account) public onlyAdmin {
        _removeFreezer(account);
    }

    /**
     * @dev Internal function to implement adding a freezer
     * @param account The account to be added as a freezer
     */
    function _addFreezer(address account) internal {
        _freezers.add(account);
        emit FreezerAdded(account);
    }

    /**
     * @dev Internal function to implement removing/renouncing freezer role
     * @param account The account to be removed as a freezer
     */
    function _removeFreezer(address account) internal {
        _freezers.remove(account);
        emit FreezerRemoved(account);
    }
}
