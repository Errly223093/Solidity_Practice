// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract settingA {
    uint public  a;

    function setA(uint _a) public {
        a = _a;
    }
}

contract controllA{
    settingA public settingA2;

    constructor(address Address){
        settingA2 = settingA(Address);
    }

    function settingA3(uint _n) public {
        settingA2.setA(_n);
    }
}

