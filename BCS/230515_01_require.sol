// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract req{
    uint a = 1;

    function getA() public view returns(uint) {
        return a;
    }

    function require1() public {
        bool c;
        a = 5;
        require(c, "error");
    }

    function setAfive() public {
        a = 5;
    }

    function require2() public {
        bool c;
        setAfive();
        require(c, "error");
    }

    function require3(uint _n) public pure returns(bool) {
        require(_n&5==0 && _n>10, "nope");
        return true;
    }

    /* 
require(bool, string memory) 의 input 만 지원한다.
require bool 값이 false 로 판단될 시, 그 함수안에 있는 모든 것을 initial state 로 되돌린다.
require2 함수와 같이 다른 함수를 호출하여 사용해도 initial state 로 돌린다.
    */

    // require 조건 2개
    function Require4(uint _n) public pure returns(bool) {
        require(_n%5==0 && _n>10, "Nope");
        return true;
    }

    // if문 안의 require
    function Require5(uint _a) public pure returns(uint) {
        if(_a%3==0) {
            require(_a%3!=0, "nope"); 
        } else if(_a%3==1) {
            return _a%3;
        } else {
            return _a%3;
        }
    }
}