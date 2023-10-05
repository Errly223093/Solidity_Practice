// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;

// 컴파일러 버전이 0.8.0 이상이라면 그냥 사용할 것.
// 컴파일러 버전이 0.8.0 미만이라면, safeMath 라이브러리를 사용할 것.

import "@openzeppelin/contracts/math/SafeMath.sol";

contract lockEther {
    using SafeMath for uint;

    mapping(address => uint) public balances;
    mapping(address => uint) public lockTime;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
        lockTime[msg.sender] = block.timestamp + 1 weeks;
    }

    function increaseLockTime(uint _increaseLockTime) public {
        // 라이브러리의 add 함수를 사용해서 over, underflow 를 방지.
        lockTime[msg.sender] = lockTime[msg.sender].add( _increaseLockTime);
    }

    function withdraw() public {
        require(balances[msg.sender] > 0, "Insufficient funds");
        require(block.timestamp > lockTime[msg.sender], "Lock time not expired");

        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;

        payable(address(msg.sender)).transfer(amount);
    }
}

contract Attack {
    lockEther lockEthers;

    constructor(address _lockEther) {
        lockEthers = lockEther(_lockEther);
    }

    receive() external payable {}

    function attack() public payable {
        lockEthers.deposit{value: msg.value}();

        // overflow 로 LockTime 값을 0으로 만들어서 곧바로 출금이 가능하도록 만듬.
        // 언락시간 + (2**256 - 언락시간) = 2**256 = 0
        // (2**256 - 언락시간) 값 만큼을 increaseLockTime 함수를 사용해서 증가시켜주면 값은 0 이 됨.
        lockEthers.increaseLockTime(
            type(uint).max + 1 - lockEthers.lockTime(address(this))
        );
    }

    function withdrawAll() public {
        lockEthers.withdraw();
    }
}