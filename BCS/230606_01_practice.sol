// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract q9{
    // 흔히들 비밀번호 만들 때 대소문자 숫자가 각각 1개씩은 포함되어 있어야 한다 등의 조건이 붙는 경우가 있습니다. 
    // 그러한 조건을 구현하세요.
    // 인풋 값을 자릿수대로 나눠서 하나씩 검사 ( 0x41~0x5A && 0x30~0x39 )


    function checkPW(string memory _pw) public pure returns(bool,bool,bool) {

        uint length;
        length = bytes(_pw).length; // 길이를 정의.

        bytes memory pw = bytes(_pw); // 배열로 담아줌.

        bool upper;
        bool lower;
        bool num;

        for(uint i; i < length; i++){
            if(pw[i] >= 0x41 && pw[i] <= 0x5A){
                upper = true;
            }
            if(pw[i] >= 0x61 && pw[i] <= 0x7A){
                lower = true;
            }
            if(pw[i] >= 0x30 && pw[i] <= 0x39){
                num = true;
            }
        }

        // require(upper == true && lower == true && num == true,"Please input appropriate word.");
        // return true;
        // 입력값을 받으면 그 입력값 안에 대문자, 소문자 그리고 숫자가 최소한 1개씩은 포함되어 있는지 
        // 여부를 알려주는 함수를 구현하세요.
        return (upper, lower, num);
    }
}