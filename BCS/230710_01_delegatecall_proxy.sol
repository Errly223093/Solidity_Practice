// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

contract A {
    uint public num;
    address public sender;

    function setNum(uint _num) public {
        num = _num;
        sender = msg.sender;
    }
}

contract B {
    uint public num;
    address public sender;

    function setNum(address _contract, uint _num) public {
        (bool success, bytes memory data) = 
        _contract.delegatecall(abi.encodeWithSignature("setNum(uint256)", _num));
        require(success, "did not work");
    }
}

contract C {
    uint public num;
    address public sender;

    function setNum(address _contract, uint _num) public {
        (bool success, bytes memory data) =
         _contract.call(abi.encodeWithSignature("setNum(uint256)", _num));
         require(success, "did not work");
    }
}

// 남이 만든 함수를 실행해서 내 변수를 바꾸는 것.
// A 컨트랙트의 함수로 B 컨트랙트의 상태변수를 수정하기.
// slot 이 바뀌거나 줄어들 수 없다. 123이라면, 123 먼저 슬롯을 만들어주고 456 같이 추가적으로 만들 수 있다.
// uint address => uint uint 로 받아오면 address(16진수) 값이 uint256(10진수) 로 바뀐다.