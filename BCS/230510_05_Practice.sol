// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract struct_map {
    struct student {
        string name;
        uint number;
        string[] classes;
    }

    student[] students; // array 형으로 선언했으므로, push 써야함. student students; 라고 선언했다면
    // student

    function setStudents(string memory _name, uint _number, string[] memory _classes) public {
        students.push(student(_name,_number,_classes)); // array 형으로 선언했으므로, push 써야함. 
        //student students; 라고 선언했다면, students = student(_name,_number,_classes);
    }

    function getStudents() public view returns(student[] memory) {
        return students;
    }

    function getStudentsNum(uint _n) public view returns(student memory) {
        return students[_n-1];
    }

    function getStudentName(uint _n) public view returns(string memory) {
        return students[_n-1].name; // student.name 의 타입은 string 이므로 returns 에는 string memory 를 넣어주어야 함.
    }

    mapping(string=>student[]) a;

    function setA(string memory _teacher, string memory _name, uint _number, string[] memory _classes) public {
        a[_teacher].push(student(_name,_number,_classes)); // a[_teacher] << 이것 자체가 하나의 배열이므로 곧바로 뒤에 .push 사용.
    }

    function getA(string memory _teacher) public view returns(student[] memory) {
        return a[_teacher];
    }
}

contract IF{
    struct student {
      uint number;
      string name;
      uint score;
      string credit;
   }

    student a;
    student b;
    student c;

    student[] Students;

    // 학생 정보 중 번호, 이름, 점수만 입력하면 학점은 자동 계산해 주는 함수
   // 점수가 90점 이상이면 A, 80점 이상이면 B, 70점 이상이면 C, 나머지는 F
    function setAStudent(uint _number, string memory _name, uint _score) public {
        string memory _credit;
        if(_score>=90) {
            _credit = "A";
        } else if(_score>= 80){
            _credit = "B";
        } else if(_score>=70){
            _credit = "C";
        } else _credit = "F";
        a = student(_number,_name,_score,_credit);
    }

        function setBStudent(uint _number, string memory _name, uint _score) public {
        string memory _credit;
        if(_score>=90) {
            _credit = "A";
        } else if(_score>= 80){
            _credit = "B";
        } else if(_score>=70){
            _credit = "C";
        } else _credit = "F";
        b = student(_number,_name,_score,_credit);
    }

        function setCStudent(uint _number, string memory _name, uint _score) public {
        string memory _credit;
        if(_score>=90) {
            _credit = "A";
        } else if(_score>= 80){
            _credit = "B";
        } else if(_score>=70){
            _credit = "C";
        } else _credit = "F";
        c = student(_number,_name,_score,_credit);
    }

        function setGrade(uint _score) public pure returns(string memory) {
      if(_score>=90) {
         return 'A';
      } else if(_score >=80) {
         return 'B';
      } else if(_score >=70) {
         return 'C';
      } else {
         return 'F';
      }
   }

    // 간편 설계  <setGrade() 함수를 불러서 간편하게 setA 함수를 작성>
   function setAStudent2(uint _number, string memory _name, uint _score) public {
        a = student(_number,_name,_score,setGrade(_score));
    }
}

contract ENUM { // enum 변수명 . 변수1,2,3,4 
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
        } // 8비트 uint 형으로 출력.

        enum team {
            kiwoom,
            LG,
            doosan,
            samsung,
            kia,
            kt
        }

        team d;
        team e;

        function kiwoom1st() public {
            d = team.kiwoom;
        }

        function doosan1st(uint _n) public {
            e = team(_n);
        }

        function getd() public view returns(team) {
            return d;
        }

        function gete() public view returns(team) {
            return e;
        }

        enum condition {
            normal,
            good,
            bad
        }

        condition cd;
        uint x=5;

        function getCondition() public { /// if 문 응용해서 함수를 만듬.
            if(x>=7){
                cd = condition.good;
            } else if(x<=3){
                cd = condition.bad;
            } else {
                cd = condition.normal;
            }
        }

        function setGcondition() public {
            x++;
            getCondition(); // if 문 응용함수를 get 함수에 사용.
        }

        function setBcondition() public {
            x--;
            getCondition();
        }

        function get() public view returns(condition) {
            return cd;
        }

        function get1() public view returns(uint) {
            return x;
        }
} 

contract review2 {
//숫자형 변수 a, 문자형 변수 b, bytes2형 변수 c를 담은 구조체 D를 선언하세요.
   
//D형 변수 dd를 선언하세요.

//dd에 값을 부여하는 setDD함수를 구현하세요.

//D형 변수들이 들어가는 array Ds를 선언하세요.

//Ds에 새로운 D형 변수를 넣는 pushD 함수를 구현하세요.

}

contract review3 {
//숫자형 변수 number, 문자형 변수 name, bytes2형 변수 password 그리고 member라는 구조체를 선언하세요.
   
//member형 변수 Michael을 선언하세요.

//Michael에 값을 부여하는 setM 함수를 구현하세요.

//member형 변수들이 들어가는 members를 선언하세요.

//members에 새로운 member 변수를 넣는 pushMember 함수를 구현하세요

}

contract review4 {
//숫자형 변수 a, 문자형 변수 b, bytes2형 변수 c를 담은 구조체 D를 선언하세요.
   
//D형 변수 dd를 선언하세요.

//dd에 값을 부여하는 setDD함수를 구현하세요.

//dd의 값을 반환하는 getDD 함수를 구현하세요(추가)

//D형 변수들이 들어가는 array Ds를 선언하세요.

//Ds에 새로운 D형 변수를 넣는 pushD 함수를 구현하세요.

//(추가) 이미 형성된 dd라는 변수를 가져와서 푸쉬도 가능.

//Ds array의 n번째 요소를 반환받는 getN이라는 함수를 구현하세요.(추가)

}