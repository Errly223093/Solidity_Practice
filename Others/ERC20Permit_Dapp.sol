// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract dapp {
    ERC20Permit public immutable token;

    constructor(address _token){
        token = ERC20Permit(_token);
    }

    function transferWithPermit(address to, uint amount, uint deadline, uint8 v, bytes32 r, bytes32 s) external {
        token.permit(msg.sender, address(this), amount, deadline, v, r, s);
        token.transferFrom(msg.sender, to, amount);
    }
} 
//  2333122312