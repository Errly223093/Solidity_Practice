// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract For {
    function forLoop() public pure returns(uint){
        uint a;

        for(uint i=1; i<6; i++ /* 시작점; 끝점; 변화방식*/){
            a = a+i;
        }

        return a;
    }

    function forLoop2() public pure returns(uint, uint){
        uint a;
        uint i;
        
        for(i=1; i<6; i++) {
            a = a+i;
        }

        return (a,i);
    }

    uint[4] c;
    uint count;

    function pushA(uint _n) public {
        c[count++] = _n;
    }

    function getC() public view returns(uint[4] memory) {
        return c;
    }

    function forLoopAdd() public view returns(uint) {
        uint a;

        for (uint i=0; i<c.length; i++) {
            a=a+c[i];
        }

        return a;
    }

    uint[] d;

    function pushd(uint _n) public {
        d.push(_n);
    }

    function getD() public view returns(uint[] memory) {
        return d;
    }

    function forLoop3() public view returns(uint) {
        uint a;
        for(uint i=0; i<d.length; i++) {
            a = a+i;
        }
        return a;
    }
    
}