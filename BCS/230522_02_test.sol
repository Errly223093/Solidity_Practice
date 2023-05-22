// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// 숫자를 시분초로 변환하세요.
// 예) 100 -> 1분 40초, 600 -> 10분, 1000 -> 16분 40초, 5250 -> 1시간 27분 30초
// 시험은 5시 52분까지입니다. 제출은 47분부터 하세요

contract test1 {
    function setTime(uint _seconds) public pure returns(uint, string memory, uint,string memory, uint,string memory) {

        uint h;
        uint m;
        uint s;

        h = _seconds / 3600;
        m = _seconds / 60;
        if(m >= 60){
            for( ; m>=60 ;){
                m = m-60;
            }
        }
        s = _seconds % 60;

        return (h,"hour",m,"minutes",s,"seconds");
    }
}

