// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract fixedArray {
    uint[] a;   // a[n]
    uint[4] b;

    function getALength() public view returns(uint) {
        return a.length;
    }

    function pushA(uint _n) public {
        a.push(_n);
    }

    function getA() public view returns(uint[] memory) {
        return a;
    }

    function getBlength() public view returns(uint) {
        return b.length;
    }

    function pushB(uint n, uint _n) public {
        b[n] = _n;
    }

    function getB() public view returns(uint[4] memory) {
        return b;
    }

    uint count; // count 상태변수 값은 0.

    function pushB2(uint _n) public {
        b[count++] = _n;  // count++ 는 b에 _n 값을 넣은 후 연산이 된다. > 0 번째 요소에 _n 을 넣음.
    }

    function pushB3(uint _n) public {
        b[++count] = _n;  // ++count 는 b에 _n 값을 넣기 전 연산이 된다. > 1 번째 요소에 _n 을 넣음.
    }

    function getCount() public view returns(uint) {
        return count;
    }
}