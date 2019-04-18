pragma solidity ^0.5.5;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Burnable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Pausable.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "ERC20Freezable.sol";

contract ITCOToken is Ownable, ERC20, ERC20Detailed, ERC20Mintable, ERC20Burnable, ERC20Pausable, ERC20Freezable {

    uint64 public constant INITIAL_SUPPLY = 100000000000; // Replace me

    constructor()
        Ownable()
        AdminRole()
        ERC20()
        ERC20Detailed("InfoTech Mutual Fund Test 2", "ITCO", 0)
        ERC20Mintable()
        ERC20Burnable()
        ERC20Pausable()
        ERC20Freezable()
        public
    {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

}
