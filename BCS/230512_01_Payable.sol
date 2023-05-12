// SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract payab1e{

    /*
    실습가이드
    1. 1번 지갑 준비(주소 복붙) -> setOwner, 2번 지갑 준비(주소 복붙) -> setA
    2. deploy 후 1번 지갑으로 10eth -> deposit()
    3. contract 잔액 변화 확인
    4. 1번 지갑 넣고, 1000000000000000000 transferTo() -> 1번지갑, contract 잔액 변화 확인
    5. 2번 지갑, 1000000000000000000, transferTo() -> 2번 지갑, contract 잔액 변화 확인

    // 1000000000000000000
    // 1. 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    // 2. 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
    */

    address a;
    address payable owner; // 돈을 받을 수 있음

    function depositcheck() public payable returns(uint){
        return msg.value;
    }

    function deposit() public payable{}
    receive() external payable{}
    
    fallback() external payable{}
    // 컨트랙트에 종속되어 있으므로, 컨트랙트가 이더를 받을 수 있게됨
    
    function setOwner() public {
        owner = payable(msg.sender); // 거래를 일으킨 사람이 payable 이 된다.
    }

    function getOwner() public view returns(address){
        return owner; // setowner 함수 실행 후 getonwer 하면, address 를 받아올 수 있다.
    }

    function setA() public {
        a = payable(msg.sender);
    }
    
    function getA() public view returns(address) {
        return a;
    }

    function transferTo(address payable _to, uint _amount) public {
        _to.transfer(_amount); // 지갑주소.transfer(보낼 양);
    } 

    function transferToOnwer(uint _amount) public {
        owner.transfer(_amount);
    }
    
    // function transferToA(uint _amount) public {
    //     a.transfer(_amount); 
    // }    // a 지갑은 payable 이 아니므로 함수 실행이 불가능
}