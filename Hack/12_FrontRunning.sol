// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

/* 
    개최자가 10 이더를 걸고 문제를 낸다.
    문제의 정답을 맞추면 10이더 획득.

    A 가 정답을 입력해 트랜잭션을 보냄, 
    트랜잭션을 모니터링 하던 B 가 A 가 제출한 트랜잭션과 똑같이 제출
    이때, B 는 트랜잭션의 가스 가격을 A 가 제출한 트랜잭션보다 높게 설정,
    B 의 트랜잭션이 먼저 실행되며 10 이더를 받아가고, A 의 트랜잭션은 무효화 됨
*/

contract EtherGame {
    address owner;
    bool isSet;

    receive() external payable { }

    constructor() {
        owner = msg.sender;
    }

    bytes32 public hash;

    function guessAnswer(string calldata _answer) public {
        require(isSet,"Game has not start yet.");
        require(hash == keccak256(abi.encodePacked(_answer)), "Incorrect answer.");

        isSet = false;

        (bool sent, ) = msg.sender.call{value: 10 ether}("");
        require(sent, "Failed to send Ether.");
    }

    function setHash(string memory _answer) public payable {
        require(msg.sender == owner,"Owner only.");
        require(isSet == false,"Game is still running.");
        require(msg.value >= 10 ether,"Minimum 10 Ether to set hash.");

        // 개최자가 이더를 걸고 게임을 개최
        payable(address(this)).transfer(msg.value);

        hash = keccak256(abi.encodePacked(_answer));
        isSet = true;
    }
}