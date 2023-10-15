// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

/*
    getOwner 로 현재 주인에게 현재 balance 이상의 
    이더를 지불하고 새로운 오너가 될 수 있다.
    attack 컨트랙트가 새로운 오너가 된다면,
    receive 또는 fallback 함수가 없어 이더를 받을 수 없고,
    오너 또한 바뀔 수 없게된다. 
*/


/// 수정 후
contract EtherGame_Defense {
    address public owner;
    uint public balance;
    mapping(address => uint) ownerBalance;

    receive() external payable { }

    function deposit() external payable {
        require(msg.value > balance, "Not enough balances.");

        payable(address(this)).transfer(msg.value);
        balance += msg.value;
        ownerBalance[owner] += msg.value;
        owner = msg.sender;
    }

    function withdraw() external {
        require(msg.sender != owner,"Not allowed for current owner.");

        uint amount = ownerBalance[msg.sender];
        ownerBalance[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}


/// 수정 전
contract EtherGame {
    address public owner;
    uint public balance;

    function getOwner() external payable {
        require(msg.value > balance, "Not enough balances.");

        payable(owner).transfer(msg.value);
        balance += msg.value;
        owner = msg.sender;
    }
}

contract Attack {
    function attack(EtherGame _EtherGame) public payable {
        _EtherGame.getOwner{value : msg.value}();
    }
}