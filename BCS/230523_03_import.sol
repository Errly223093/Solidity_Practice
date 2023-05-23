// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import './230523_04_import2.sol';
import './230523_05_import3.sol';

contract B_smartContract{
    function add(uint _a, uint _b) public pure returns(uint) {
        return _a+_a+_b;
    }

    function multi(uint _n) public view returns(uint) {
        return C.utos(_n);
    }
}

