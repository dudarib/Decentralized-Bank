// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
  address public minter;  //add minter variable

  event MinterChanged(address indexed from, address to);   //add minter changed event

  constructor() public payable ERC20('Decentralized Euro Currency' , "DEC") {
    minter = msg.sender;  //asign initial minter
  }

  //Add pass minter role function
  function passMinterRole(address dBank) public returns (bool) {
    require(msg.sender == minter, 'ERROR, only owner can change pass minter role');
    minter = dBank;

    emit MinterChanged(msg.sender, dBank);
    return true;
  }

  function mint(address account, uint256 amount) public {
    require(msg.sender == minter, 'ERROR, msg.sender does not have minter');   //check if msg.sender have minter role
		_mint(account, amount);
	}
}