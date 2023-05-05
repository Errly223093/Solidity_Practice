// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.18;


contract Array {
    // array = 같은 자료형들이 들어있는 집합
    uint[] numbers; // 자료형 [] array 이름

    // 1. 넣기
    function push(uint _a) public {
        numbers.push(_a); // 배열이름.push(변수)
    }

    // 2. 빼기
    function pop() public {
        numbers.pop(); // 배열이름.pop(), 맨뒤의 숫자를 날림
    }

    // 3. 보기
    function getNumber(uint _n) public view returns(uint) {
        return numbers[_n-1]; // 배열이름[_n번째]
    }

    // 4. 길이
    function getLength() public view returns(uint) {
        return numbers.length; //배열이름.길이
    }

    // 5. 바꾸기
    function changeNum(uint _k, uint _z) public {
        numbers[_k-1] = _z; //배열이름[_k번째] = _z -> _k번째를 _z로 바꿔
    }

    // 6. delete 
    function deleteNum(uint _n) public {
        delete numbers[_n-1]; // delete 배열이름[_n번째] = _n번째 숫자를 없애줘
    }

    //7. 전체 array 반환
    function returnArray() public view returns(uint[] memory) {
        return numbers;
    }
}

contract Array_s {
    // array = 같은 자료형들이 들어있는 집합
    string[] letters; // 자료형 [] array 이름

    // 1. 넣기
    function push(string memory _a) public {
        letters.push(_a); // 배열이름.push(변수)
    }

    // 2. 빼기
    function pop() public {
        letters.pop(); // 배열이름.pop(), 맨뒤의 숫자를 날림
    }

    // 3. 보기
    function getLetter(uint _n) public view returns(string memory) {
        return letters[_n-1]; // 배열이름[_n번째]
    }

    // 4. 길이
    function getLength() public view returns(uint) {
        return letters.length; //배열이름.길이
    }

    // 5. 바꾸기
    function changeLet(uint _k, string memory _z) public {
        letters[_k-1] = _z; //배열이름[_k번째] = _z -> _k번째를 _z로 바꿔
    }

    // 6. delete 
    function deleteLet(uint _n) public {
        delete letters[_n-1]; // delete 배열이름[_n번째] = _n번째 숫자를 없애줘
    }

    //7. 전체 array 반환
    function returnArray() public view returns(string[] memory) {
        return letters;
    }
}