// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract BOOL{
    bool isFun = true; // => 초기값이 true 인 bool 상태변수 선언
    // bool isFun; => 기본값은 false

    function getISfun() public view returns(bool) {
        return isFun;
    }

    function setFun() public {
        isFun = true;
    }

    function FunSwitch() public {
        isFun = !isFun;
    }

    function setFun2(bool _a) public {
        isFun = _a; // 어떠한 값이 들어간다면 fun 이 됨.
    }
}