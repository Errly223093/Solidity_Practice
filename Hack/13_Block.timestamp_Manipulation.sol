// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
    Casino 컨트랙트의 slotMachine, guessTime 함수를 사용해 게임에 참여할 수 있다.
    게임에 참여하는 slotMachine 함수를 실행하는 트랜잭션을 보낼 때의 값이,
    block.timestamp % 7 == 1 이라는 조건에 맞아야 컨트랙트에 있는 이더를 받을 수 있다.
    guessTime 함수는 인자를 unix 시간으로 받으며, 현재 시간을 정확히 맞춘다면 이더를 받을 수 있다.

    이더리움 블록의 타임스탬프는 정확하지 않다.
    첫 번째 이유는, 채굴자가 네트워크 시간의 특정 범위 내에 있으면 타임스탬프를 어느 정도 조작할 수 있다.
    따라서 타임스탬프는 블록이 채굴된 시점을 정확히 측정한 것이 아닌 채굴된 시간의 근사치이다.
    두 번째 이유는, 블록의 채굴 과정을 생각해볼때 네트워크 지연 및 다른 요인들로 인해 정보가 
    이더리움 네트워크를 통해 전송되는 데 걸리는 시간의 변동에 타임스탬프의 값이 영향을 받을 수 있다.

    "타임스탬프는 항상 근사치이며 정확한 값이 아니다" 라는 것, 
    그리고 블록의 생성은 매 10~15초 이며 ~15초 정도의 변동성을 감안하는 15초 룰을 염두하며 개발.
*/

contract Casino {
    constructor() payable {
        require(msg.value == 2 ether, "Require 2 ethers to activate.");
        payable(this).transfer(2 ether);
    }

    receive() external payable {}

    function slotMachine() public payable {
        require(msg.value == 1 ether, "require 1 ether.");

        (bool transfer, ) = address(this).call{value : msg.value}("");
        require(transfer,"Failed to send ether.");

        if(block.timestamp % 7 == 1){
            payable(msg.sender).transfer(address(this).balance - 2 ether);
        }
    }

    function guessTime(uint _unixTime) public payable {
        require(msg.value == 1 ether, "require 1 ether.");

        (bool transfer, ) = address(this).call{value : msg.value}("");
        require(transfer,"Failed to send ether.");

        if(block.timestamp == _unixTime){
            payable(msg.sender).transfer(address(this).balance - 2 ether);
        }
    }
}