// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.18;

contract note {
    struct Student {
        string name;
        uint birth;
        uint number;
    }

    Student[] students;

    // students에 Student를 넣을 수 있는 함수, n번째 학생을 반환해주는 함수,
    // n번째 학생의 이름을 반환해주는 함수를 구현하세요.

    function pushStudents(string memory _name, uint _birth, uint _number) public {
        students.push(Student(_name,_birth,_number));
    }

    function getStudents(uint _n) public view returns(string memory) {
        return students[_n-1].name;
    }

    function getName(uint _n) public view returns(Student memory) {
        return students[_n-1];
    }
}

/*이름 a, 번호 b, bytes2 c를 담은 구조체 D
D형 변수 ddd를 선언하시오.*/

contract note2 {
    struct D {
        string a;
        uint b;
        bytes2 c;
    }

    D ddd;

    // ddd에 값을 부여하는 함수를 구현하시오.
    function setddd(string memory _a, uint _b, bytes2 _c) public {
        ddd = D(_a,_b,_c);
    }

    // D가 들어가는 array D_list를 선언하시오.
    D[] D_list;

    // D_list 전체를 반환하는 함수, D_list 안에서 n번째 데이터를 반환하는 함수를 각각 구현하시오.
    function getD_list() public view returns(D[] memory) { // 배열 전체를 가져오므로 D[]
        return D_list; 
    }

    function getNumD_list(uint _n) public view returns(D memory) { // 배열의 n 번째를 가져오므로 D
        return D_list[_n-1];
    }
}


// ABC라는 구조체 안에는 숫자형 a, 문자형 b, 문자형 array c가 들어있다.
// 
contract note3 {
    struct ABC {
        uint a;
        string b;
        string[] c;
    }

    ABC[] ABCs;

    // ABCs에 ABC를 넣는 함수, 
    function pushABCs(uint _a, string memory _b, string[] memory _c) public {
        ABCs.push(ABC(_a,_b,_c));
    }

    // 특정 ABC를 반환하는 함수
    function getABC(uint _n) public view returns(ABC memory) {
        return ABCs[_n-1];
    }

    // ABCs 전체를 반환하는 함수
    function getAllABC() public view returns(ABC[] memory) {
        return ABCs;
    }

    // 특정 ABC의 c array를 반환받는 함수를 각각 구현하시오.
    function getCOfABC(uint _n) public view returns(string[] memory) {
        return ABCs[_n-1].c;
    }
}