// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

/* 
selfdestruct 에 대한 테스트 컨트랙트

selfdestruct 된 컨트랙트는 더 이상 사용할 수 없음.
상태변수를 변경하거나 입금하는 등의 트랜잭션도 정상으로 처리됨.
하지만, 상태변수 값은 0 으로 고정되어 있고, 컨트랙트에 모인 이더를 출금하는 등의 행위도 할 수 없음.
*/
contract test_selfdestruct{
    uint a = 1;
    
    receive() external payable { }

    function getA() public view returns(uint) {
        return a;
    }

    function plusA() public {
        a += 1;
    }

    function sendEther() public payable {
        payable(address(this)).transfer(msg.value);
    }

    function selfDestruct(address _address) public {
        address payable addr = payable(address(_address));
        selfdestruct(addr);
    }
}

contract EtherGame {
    uint public targetAmount = 7 ether;
    address public winner;
    // balance 상태변수 선언
    uint balance;

    function deposit() public payable {
        require(msg.value == 1 ether, "You can only send 1 Ether");

        // deposit 을 통해 입금한 이더만을 계산
        balance += msg.value;
        require(balance <= targetAmount, "Game is over");

        if (balance == targetAmount) {
            winner = msg.sender;
        }
    }

    function claimReward() public {
        require(msg.sender == winner, "Not winner");

        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }
}

contract Attack {
    EtherGame etherGame;

    constructor(EtherGame _etherGame) {
        etherGame = EtherGame(_etherGame);
    }

    function attack() public payable {
        address payable addr = payable(address(etherGame));
        selfdestruct(addr);
    }
}