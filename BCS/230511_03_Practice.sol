// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.18;

contract asdca {

    enum mainEngine {
	fullahead,
    slowahead,
    stop,
    slowastern,
    fullastern
    }

    mainEngine eng1;

    uint engCondition=5;

        function set_ME_ahead() public {
	    engCondition++;
        // ifCondition();
    }

    function set_ME_astern() public {
	    engCondition--;
        // ifCondition();
    }

    function get_ME_Condition() public view returns(mainEngine) {
	    return eng1;
    }

    // function ifcondition() public {
    //     if(engCondition >= 9){
    //         eng1 = mainEngine.fullahead;
    //     } else if(engCondition >=7){
    //         eng1 = mainEngine.slowahead;
    //     } else if(engCondition ==5){
    //         eng1 = mainEngine.stop;
    //     } else if(engCondition <= 3) {
    //         eng1 = mainEngine.slowastern;
    //     } else {
    //         eng1 = mainEngine.fullastern;
    //     }
    // }
}

contract booooolean {
    bool a;

    function geta() public view returns(bool) {
        return a;
    }

    function seta() public {
        a = true;
    }
}

contract test1{
// 여러분은 선생님입니다. 학생들의 정보를 관리하려고 합니다. 
// 학생의 정보는 이름, 번호, 점수, 학점 그리고 듣는 수업들이 포함되어야 합니다.
    struct student {
        string name;
        uint number;
        uint score;
        string credit;
        string[] classes;
    }

    student[] students;

// 번호는 1번부터 시작하여 정보를 기입하는 순으로 순차적으로 증가합니다.

// 학점은 점수에 따라 자동으로 계산되어 기입하게 합니다. 90점 이상 A, 80점 이상 B, 70점 이상 C, 60점 이상 D, 나머지는 F 입니다.
    function setCredit(uint _score) public pure returns(string memory) {
        if(_score>=90){
            return "A";
        } else if(_score>=80){
            return "B";
        } else if(_score>=70){
            return "C";
        } else if(_score>=60){
            return "D";
        } else {
            return "F";
        }
    }

// 필요한 기능들은 아래와 같습니다.

// * 학생 추가 기능 - 특정 학생의 정보를 추가
    function setStudent(string memory _name, uint _score, string[] memory _classes) public {
        students.push(student(_name, students.length+1, _score, setCredit(_score), _classes));
        mapstudents[_name] = student(_name, students.length, _score, setCredit(_score), _classes);
    }
// * 학생 조회 기능(1) - 특정 학생의 번호를 입력하면 그 학생 전체 정보를 반환
    function getStudent(uint _number) public view returns(student memory) {
        return students[_number-1];
    }
// * 학생 조회 기능(2) - 특정 학생의 이름을 입력하면 그 학생 전체 정보를 반환
    mapping(string=>student) mapstudents;

    function getStudent2(string memory _name) public view returns(student memory) {
        return mapstudents[_name];
    } 
// * 학생 점수 조회 기능 - 특정 학생의 이름을 입력하면 그 학생의 점수를 반환
    function getStudent3(string memory _name) public view returns(uint) {
        return mapstudents[_name].score;
    } 
// * 학생 전체 숫자 조회 기능 - 현재 등록된 학생들의 숫자를 반환
    function getStudent4() public view returns(uint) {
        return students.length;
    }

// * 학생 전체 정보 조회 기능 - 현재 등록된 모든 학생들의 정보를 반환
    function getStudent5() public view returns(student[] memory) {
        return students;
    }
// * 학생들의 전체 평균 점수 계산 기능 - 학생들의 전체 평균 점수를 반환
    function getAverage() public view returns(uint) {
        uint sum;
        for(uint i; i<students.length; i++){
            sum = sum + students[i].score;
        }
        return sum / students.length;
    }
// * 선생 지도 자격 자가 평가 시스템 - 학생들의 평균 점수가 70점 이상이면 true, 아니면 false를 반환
    function evaluateSys() public view returns(bool) {
        if(getAverage() >= 70){
            return true;
        } else {
            return false;
        }
    }

// * 보충반 조회 기능 - F 학점을 받은 학생들의 숫자와 그 전체 정보를 반환
    student[] fstudents;

    function getF() public returns(uint) {
        for(uint i; i < students.length; i++){
            if(keccak256(bytes(students[i].credit)) == keccak256(bytes("F"))){
                fstudents.push(students[i]);
            }
        }
        return fstudents.length;
    } 
// -------------------------------------------------------------------------------
// * S반 조회 기능 - 가장 점수가 높은 학생 4명을 S반으로 설정하는데, 이 학생들의 전체 정보를 반환하는 기능 (S반은 4명으로 한정)

// 기입할 학생들의 정보는 아래와 같습니다.

// Alice, 1, 85
// Bob,2, 75
// Charlie,3,60
// Dwayne, 4, 90
// Ellen,5,65
// Fitz,6,50
// Garret,7,80
// Hubert,8,90
// Isabel,9,100
// Jane,10,70
}