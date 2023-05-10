// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;


// ENUM 은 string => int 형으로 저장되면서 변수를 관리하기가 편해진다.
// ENUM array 의 차이는 array 는 요소 자체를 수정할 수 있음.(pop push delete..)
// enum 은 변하지 않는 규칙을 설정하고, 그 규칙에 맞추어서 상태를 수정하는 것.
// st = st2[0]; & st = Status.low; >> 당장 코드 작성을 하더라도, 가독성이 좋다.
// string[] st; 형태는 size 가 커 동적이 되므로 많이 소모되어 가스비가 증가하게 됨.
// 하지만, enum 은 0,1,2,3,4 등의 uint8 size 로 지정되어있어 정적, 가스비가 적게 소모 됨.


contract ENUM { // enum 변수명 {변수1,2,3,4}
        enum Food { 
            chicken, // 0 으로 저장
            suish, // 1
            Bread, // 2
            Coconut // 3
        }

        Food a;
        Food b;
        Food c;

        function setA() public {
            a = Food.chicken;
            
        }

        function setB() public {
            b = Food.suish;
        }

        function setC() public {
            c = Food.Bread;
        }

        function getABC() public view returns(Food, Food, Food) {
            return (a,b,c); // Food 자료형이다.
        }
        
        function getABC2() public view returns(uint8, uint8, uint8) {
            return(uint8(a),uint8(b),uint8(c));
        }
    }

contract ENUM2 {
    enum color {
        red,
        yellow,
        blue,
        purple,
        brown,
        ivory,
        green
    }

    color c;

    function setC() public {
        c = color.red;
    }
    
    function setC2(uint _n) public {
        c = color(_n); // enum 의 변수명은 index 형태로 저장됨.
    }

    function getC() public view returns(color) {
        return c;
    }
}

contract ENUM3 {
    enum Status {
        neutral,
        high,
        low
    }
    Status st;

    uint a=5;

    function higher() public {
        a++; // 7이상
        setA(); // setA 함수를 가져옴.
    }

    function Lower() public {
        a--; // 3이하
        setA();
    }

    function setA() public {
        if(a>=7){
            st = Status.high;
        } else if(a<=3){
            st = Status.low;
        } else {
            st = Status.neutral;
        }
    }

    function getA() public view returns(uint) {
        return a;
    }

    function getSt() public view returns(Status) {
        return st;
    }

    
}