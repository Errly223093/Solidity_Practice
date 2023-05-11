// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Test{
    struct student{
        string name;
        uint number;
        uint score;
        string credit;
    }

    student[] students;

    mapping(string=>student) students2;

    //번호는 1번부터 시작하여 정보를 기입하는 순으로 순차적으로 증가합니다.
    // function numbering() public view returns(uint){
    //     return students.length + 1;
    // }

    //학점은 점수에 따라 자동으로 계산되어 기입하게 합니다. 90점 이상 A, 80점 이상 B, 70점 이상 C, 60점 이상 D, 나머지는 F 입니다.
    function setCredit(uint _score) public pure returns(string memory) {
      if(_score>=90) {
         return 'A';
      } else if(_score >=80) {
         return 'B';
      } else if(_score >=70) {
         return 'C';
      } else if(_score >=60) {
        return 'D';
      } else {
        return 'F';
      }
   }

    // * 학생 추가 기능 - 특정 학생의 정보를 추가
    function addStudent(string memory _name, uint _score, string memory _credit) public {
        students.push(student(_name,students.length+1,_score,_credit));
        students2[_name] = student(_name,_score,students.length,_credit);
    }

    // * 학생 조회 기능(1) - 특정 학생의 번호를 입력하면 그 학생 전체 정보를 반환
    function getStudent(uint _n) public view returns(student memory) {
        return students[_n-1];
    }

    // * 학생 조회 기능(2) - 특정 학생의 이름을 입력하면 그 학생 전체 정보를 반환
    function getName2students(string memory _name) public view returns(student memory) {
        return students2[_name];
    }

    // * 학생 점수 조회 기능 - 특정 학생의 이름을 입력하면 그 학생의 점수를 반환
    function getName2score(string memory _name) public view returns(uint) { 
        return students2[_name].score;
    }

    // * 학생 전체 숫자 조회 기능 - 현재 등록된 학생들의 숫자를 반환
    function getStudentslength() public view returns(uint) {
        return students.length;
    }

    // * 학생 전체 정보 조회 기능 - 현재 등록된 모든 학생들의 정보를 반환
    function getAllstudents() public view returns(student[] memory) {
        return students;
    }

    // * 학생들의 전체 평균 점수 계산 기능 - 학생들의 전체 평균 점수를 반환
    function getAverage() public view returns(uint) {
        // 계산방법 : 모든 학생의 점수 / 학생 수
        // return students[1].score; 를 10번
        uint sum;
        for(uint i=0; i<students.length; i++){
            sum = sum + students[i].score;
        }
        return sum/getStudentslength();
    }

    // * 선생 지도 자격 자가 평가 시스템 - 학생들의 평균 점수가 70점 이상이면 true, 아니면 false를 반환
    function autoEvaluate() public view returns(bool){
        if(getAverage()>=70){
            return true;
        } else {
            return false;
        }
    }

    // * 보충반 조회 기능 - F 학점을 받은 학생들의 숫자와 그 전체 정보를 반환
    function getFclass() public view returns(student[] memory) {
        uint num; // f 학점의 학생 수
        student[] memory FStudent = new student[](num); // [] 안에 변수를 넣어줘도 안됨. 변수는 계속 바뀌기에 값을 제한시킬 수 없음.
        // bytes memory resultBytes = new bytes(1);
        // resultBytes[0] = bytes(_a)[_n]; @@@@@@@@@@@@@참조@@@@@@@@@

        for(uint i=0; i < students.length; i++){
            if(keccak256(bytes(students[i].credit)) == keccak256(bytes("F"))) {
                // 밖의 메모리를 참조할 수 없음. // push 로는 배열의 키를 정해주어야 함. 
                FStudent[num] = students[i];
            }
        }
        return FStudent;
    }
    // 목표는 두번 갔다오는거 ok 근데 둘다 못하는 이유는 뭐냐 첫번째로 애시당초 선언을 했을 때 길이가 몇인지를 몰라서 동적으로 적어줌 
    // 근데 길이를 동적으로 적었기때문에 동적인 길이가 정확히 몇인지 알기 전까지는 선언 불가능 
    // 그래서 그 안에 넣고 빼고를 못해
    // 그러면 우리가 할 수 있는건 두가지 방법인데
    // 1. 아무길이 설정하고 그 길이에 도달하면 길이를 늘려주는거, 늘려줄때
    // 2. 새로운애가 생길 때마다 하나씩 하나씩 늘려주는거
    // 2.1에서 중요한건 길이를 늘려주면 어떤게 문제일까(new선언하고나서) 가장 큰 문제는 기존에 있는 정보들이 날라가버림(new로 해버리면) 
    // 그럼 기존에 있던 애들을 잠시 어디에 뒀다가 가져와야겠죠?
    // 그런 다음에 길이를 늘렸다가 저장해둔 아이를 새롭게 길이를 늘린 애한테 주면되겠죠?


    // * S반 조회 기능 - 가장 점수가 높은 학생 4명을 S반으로 설정하는데, 이 학생들의 전체 정보를 반환하는 기능 (S반은 4명으로 한정)
}

contract aaaa{
    function compare1(string memory s1) public pure returns(bytes32){
        return keccak256(abi.encodePacked(s1));
    }

    function compare2(string memory s1) public pure returns(bytes32){
        return keccak256(bytes(s1));
    }

}
