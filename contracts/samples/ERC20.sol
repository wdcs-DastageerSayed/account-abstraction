// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

error NotEnoughFunds();

contract AccAbs is ERC20, ERC20Burnable, Ownable, ERC20Permit {

    uint256 value = 0.001 ether;
    constructor() ERC20("AccAbs", "ACB") ERC20Permit("AccAbs") {}

    function mint(address to, uint256 amount) public payable  {
        if(msg.value != value * amount) revert NotEnoughFunds();
        _mint(to, amount);
        payable(address(this)).call{value : msg.value};
    }

    function mintMSG(uint256 amount) public {
        _mint(msg.sender, amount);
    }
}
