// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import './230523_03_import.sol';

contract A {
    B_smartContract b = new B_smartContract();

    function add(uint _a, uint _b) public view returns(uint) {
        return b.add(_a, _b);
    }
}