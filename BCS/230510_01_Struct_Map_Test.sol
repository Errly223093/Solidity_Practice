// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract abc {
    struct student {
        string name;
        uint number;
        string[] classes;
    }

    student[] students;

    function setStudents(string memory _name, uint _number, string[] memory _classes) public {
        students.push(student(_name,_number,_classes));
    }

    function getStudents(uint _n) public view returns(student memory) {
        return students[_n-1];
    }

    function getStudentName(uint _n) public view returns(string memory) {
        return students[_n-1].name;
    }

    mapping(string=>student[]) map;

    function set(string memory _Teacher, string memory _name, uint _number, string[] memory _classes) public  {
        map[_Teacher].push(student(_name, _number, _classes));
    }

    function set2(string memory _aa, uint _n, uint _number) public {
        map[_aa][_n-1].number = _number;
    }

    function get(string memory _Teacher) public view returns(student[] memory) {
        return map[_Teacher];
    }
}

// 0:tuple(string,uint256,string[])[]: name,1,math,name2,2,math,name3,3,math,english