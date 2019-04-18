pragma solidity ^0.5.2;

import "openzeppelin-solidity/contracts/access/Roles.sol";
import "AdminRole.sol";

contract FreezerRole is AdminRole {
    using Roles for Roles.Role;

    event FreezerAdded(address indexed account);
    event FreezerRemoved(address indexed account);

    Roles.Role private _freezers;

    constructor () internal {
        _addFreezer(msg.sender);
    }

    modifier onlyFreezer() {
        require(isFreezer(msg.sender));
        _;
    }

    function isFreezer(address account) public view returns (bool) {
        return _freezers.has(account);
    }

    function addFreezer(address account) public onlyAdmin {
        _addFreezer(account);
    }

    function renounceFreezer() public {
        _removeFreezer(msg.sender);
    }

    function _addFreezer(address account) internal {
        _freezers.add(account);
        emit FreezerAdded(account);
    }

    function _removeFreezer(address account) internal {
        _freezers.remove(account);
        emit FreezerRemoved(account);
    }
}
