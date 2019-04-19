pragma solidity ^0.5.2;

import "./ERC20.sol";
import "AdminRole.sol";

/**
 * @title Burnable Token
 * @dev Token that can be irreversibly burned (destroyed). This contract has
 * been modified from the original library to only allow admins to burn tokens
 */
contract ERC20Burnable is ERC20, AdminRole {
    /**
     * @dev Burns a specific amount of tokens. Admin only.
     * @param value The amount of token to be burned.
     */
    function burn(uint256 value) public onlyAdmin {
        _burn(msg.sender, value);
    }

    /**
     * @dev Burns a specific amount of tokens from the target address. Admin
     * only function.
     * @param from address The account whose tokens will be burned.
     * @param value uint256 The amount of token to be burned.
     */
    function burnFrom(address from, uint256 value) public onlyAdmin {
        _burn(from, value);
    }
}
