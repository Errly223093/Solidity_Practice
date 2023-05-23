// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract AA {
    bytes20 a;
    address b;

    constructor() {
        b = msg.sender;
    }

    function AAA() public view returns(address) {
        return address(a);
    }

    function AAB() public view returns(bytes1) {
        return bytes20(b)[0];
    }
}