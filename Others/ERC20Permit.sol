// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract TESTUSDT is ERC20, ERC20Permit {

    constructor(uint amount) ERC20("TEST USDT", "USDT") ERC20Permit("TEST USDT") {
        _mint(msg.sender, amount);
    }

    function decimals() public override pure returns(uint8){
        return 0;
    }
}