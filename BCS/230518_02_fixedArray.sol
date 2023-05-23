// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

/*
B2는 count라는 state variable 사용 -> 개선의 여지가 있음
B3는 state variable 사용 (x)

실습가이드
1. pushB3() 사용해서 1,2,3,4 넣기
2. getAB()와 getLengthOfB() 활용해서 길이 변화 확인
3. pushB3() 사용해서 5 넣기
4. getAB()와 getLengthOfB() 활용해서 변화 확인
*/

contract FixedDynamic {

    uint[4] public b;

    function pushB(uint _a) public {
        require(_a !=0);
        if(getLengthOfB()==4) {
            delete b;
        }
        
        b[getLengthOfB()] = _a;
    }
    
    function getLengthOfB() public view returns(uint) {
        for(uint i=0; i<4; i++) {
            if(b[i]==0) {
                return i;
            }
        }
        return 4;
    }
}