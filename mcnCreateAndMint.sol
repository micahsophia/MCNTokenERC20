// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MiCoin is ERC20 {
  address public owner;

  constructor(uint256 initialSupply) ERC20("MiCoin", "MCN") {
    _mint(msg.sender, initialSupply * 10 ** uint256(decimals()));
    owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == owner, "Only the owner can call this function");
    _;
  }

  function mint(address to, uint256 value) external onlyOwner {
    _mint(to, value);
  }

  function burn(uint256 value) external {
    _burn(msg.sender, value);
  }

  function transfer(address to, uint256 value) public override returns (bool) {
    require(balanceOf(msg.sender) >= value, "Insufficient balance");
    _transfer(msg.sender, to, value);
    return true;
  }
}