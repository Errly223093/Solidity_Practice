// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// 형 변환


contract stringtobytespractice {

    // 목표는 asdf 의 맨 앞글자를 가져오는 것.
    string a;

    function setString(string memory _a) public {
        a = _a;
    }
    
    function getString() public view returns(string memory) {
        return a;
    }

    function StringToBytes() public view returns(bytes memory) {
        return bytes(a);
    }

    function StringToBytes2() public view returns(bytes1,bytes1,bytes1,bytes1) {
        return (bytes(a)[0], bytes(a)[1], bytes(a)[2], bytes(a)[3]);
    }

    function BytesToString1(bytes memory _a) public pure returns(string memory) {
        return string(_a);
    }
    
    function BytesToString2() public view returns(string memory) {
        return string(a);
    }

    function BytesToString3(string memory _a) public pure returns(string memory) {
        bytes memory b = new bytes(1); // b 라는 바이트형 지역변수를 만들고, 1바이트 크기 라고 선언
        b[0] = bytes(_a)[0]; // b의 0번째 배열에 _a 의 0번째 배열 바이트를 넣어줌. = a 의 바이트를 넣는것과 같음. => 0x61
        return string(b); // b를 문자형식으로 으로 반환함.
    } 
}

// Array

contract array{
    uint[] count; // count 라는 uint형식의 배열 상태변수를 선언.
    
    function pushArray(uint _a) public {
        count.push(_a);
    }

    function getArray() public view returns(uint[] memory) {
        return count;
    }

    function popArray() public {
        count.pop();
    }

    function getNumberArray(uint _n) public view returns(uint) {
        return count[_n-1]; // 0번째 배열이 1로 시작한다는 전제로 -1 해준다.
    }

    function getLengthArray() public view returns(uint) {
        return count.length; // 배열의 길이를 반환한다.
    }

    function getChangeNumArray(uint _n, uint _b) public {
        count[_n-1] = _b; // n-1 번째 배열에 _b 값을 넣는다.
    }

    function deleteNumArray(uint _n) public {
        delete count[_n-1]; // delete 는 배열을 삭제하는 것이 아닌, 배열의 n 번째 값을 초기화 한다. 4였다면 0으로.
    }

    function getNumArray(uint _n) public view returns(uint) {
        return count[_n-1]; // _n 번째 배열의 값을 반환함.
    }
}

// string 형식 array

contract stringArray {
    string[] abc;

    function pushstringarray(string memory _a) public {
        abc.push(_a);
    }

    function popstringarray() public {
        abc.pop();
    }

    function getallstringarray() public view returns(string[] memory) {
        return abc;
    } 

    function getlengthofstirngarray() public view returns(uint){
        return abc.length;
    } 

    function changestringarray(uint _n, string memory _a) public {
        abc[_n-1] = _a;
    }
    
    function deletestringarray(uint _n) public {
        delete abc[_n-1];
    }
}

// struct 구조
contract structpractice {
    struct school {
        string name;
        uint rank;
        string position;
    }
    
    school s;
    school[] scharray; // school 형 배열 scharray 선언. => 비슷한 예시로 uint[] scharray / string[] scharray 라고 생각하면 이해하기 쉽다.

    function setSchool(string memory _name, uint _rank, string memory _position) public {
        s = school(_name, _rank, _position);
    }

    function getS() public view returns(school memory) {
        return s;
    }

    function pushSchool(string memory _name, uint _rank, string memory _position) public {
        scharray.push(school(_name, _rank, _position));
    }

    function getScharray() public view returns(school[] memory) {
        return scharray;
    }
}
