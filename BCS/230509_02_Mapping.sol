// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract note{
    mapping(uint => uint) a;
    mapping(string => uint) b;
    mapping(bytes => uint) c;

    function setb(string memory _a, uint _b) public {
        b[_a] = _b; // key value 쌍이므로 VALUE 와 KEY 를 지정해준다.
    }

    function setbravo(string memory _key, uint _value) public {
        b[_key] = _value;
    } 

    function getbravo(string memory _key) public view returns(uint) {
        return b[_key]; // key 만 넣어줘도 value 를 돌려줌.
    }

    function setC(bytes memory _key, uint _value) public {
        c[_key] = _value;
    }
    
    function getC(bytes memory _key) public view returns(uint) {
        return c[_key];
    }

    struct Student{
        uint number;
        string name;
        string[] classes;
    }

    mapping (string=>Student) Teacher_Student; 
    // Teacher_Student 라는 key-value 쌍 상태변수를 선언했다고 볼 수 있다.
    mapping(string=>Student[]) Teacher_Class;

    function setTeacherStudent(string memory _Teacher, uint _number, string memory _name, string[] memory _classes) public {
       Teacher_Student[_Teacher] = Student(_number,_name,_classes);
    }
        // key = value 쌍으로 지정.

    function getTeacherStudent(string memory _Teacher) public view returns(Student memory) {
        return Teacher_Student[_Teacher];
    }

    function setTeacherClass(string memory _Teacher, uint _number, string memory _name, string[] memory _classes) public {
        Teacher_Class[_Teacher].push(Student(_number,_name,_classes));
    } //이미 이것만으로 value = 배열이다. 바로 push 사용가능.

    function getTeacherClass(string memory _Teacher) public view returns(Student[] memory) {
        return Teacher_Class[_Teacher];
    }
}