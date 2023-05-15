// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract CONSTRUCTOR {
    uint a;
    uint b;

    constructor() {
        b = 4;
    }

    function setA() public {
        a = 5;
    }

    function getA() public view returns(uint) {
        return a;
    }

    function getB() public view returns(uint) {
        return b;
    }
}

contract CONSTRUCTOR5 {
    /*
    1. 1번 지갑으로 배포, value는 10eth로
    2. 배포 후 지갑 잔고 확인
    3. 2번 지갑으로 deposit() 1eth // 3,4,5번 지갑으로 똑같이 실행
    4. 지갑 잔고 확인 후, 2번 지갑으로 trnasferTo 시도, _to의 지갑 주소는 6번 지갑 금액은 5eth 
    5. 1번 지갑으로 transferTo 시도, _to의 지갑 주소는 6번 지갑 금액은 5eth
    6. 2번 지갑으로 withdraw 함수 시도, 1번 지갑으로 withdraw 함수 시도
    */
    address payable owner;

    constructor() payable { 
        payable(this).transfer(msg.value); // 배포할 때 msg.value 만큼 contract 에게 입금
        owner = payable(msg.sender); // 배포하는 지갑 주소가 바로 owner 로 설정
    }
    
    function getOwner() public view returns(address) {
        return owner;
    }
    // contract 가 to 에게 amount 만큼 보냄
    function transferTo(address payable _to, uint _amount) public {
        require(msg.sender == owner, "only owner can transfer asset");
        _to.transfer(_amount);
    }
    
    receive() external payable{}
    // contract 가 msg.value 만큼 돈을 받는 함수
    function deposit() public payable returns(uint){
        return msg.value;
    }
    // contract 가 owner 에게 전액 돈을 보내는 함수, owner 입장에서는 전액 인출.
    function withdraw() public {
        require(msg.sender == owner, "owner only");
        owner.transfer(address(this).balance);
    }

    // contract 가 owner 에게 돈을 보내ㅡㄴ 함수
    function withdraw2(uint _amount) public {
        require(msg.sender == owner, "owner only");
        owner.transfer(_amount);
    }

        function withdraw3() public {
        require(msg.sender == owner, "owner only");
        owner.transfer(1 ether);
    }
}