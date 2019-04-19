pragma solidity ^0.5.5;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Burnable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Pausable.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "contracts/token/ERC20Freezable.sol";

/**
* @author ITMF Ltd.
* @title ITCOToken - Primary contract class for ITCO
*/
contract ITCOToken is Ownable, ERC20, ERC20Detailed, ERC20Mintable,
    ERC20Burnable, ERC20Pausable, ERC20Freezable {

    uint64 public constant INITIAL_SUPPLY = 525000000;

    constructor()
        Ownable()
        AdminRole()
        ERC20()
        ERC20Detailed("InfoTech Mutual Fund Coin", "ITCO", 0)
        ERC20Mintable()
        ERC20Burnable()
        ERC20Pausable()
        ERC20Freezable()
        public
    {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

}
