// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Bank {
    mapping(address => uint) balances;
    Logger logger;

    constructor(Logger _logger) {
        logger = Logger(_logger);
    }

    function deposit() external payable{
        balances[msg.sender] += msg.value;
        logger.logDeposit();
    }

    function withdraw(uint _amount) public {
        require(balances[msg.sender] >= _amount, "Balance less than 1 ether.");

        payable(msg.sender).transfer(_amount);
        balances[msg.sender] -= _amount;
        logger.logWithdraw();
    }

    function checkBalances() external view returns(uint){
        return balances[msg.sender];
    }
}

contract Logger {
    event withdraw(string _event, address _txorigin, uint _amount);

    function logWithdraw() external payable {
        emit withdraw("Withdraw", tx.origin, msg.value);
    }

    function logDeposit() external payable {
        emit withdraw("Deposit", tx.origin, msg.value);
    }
}

contract HoneyPot {
    event withdraw(string _event, address _msgSender);
    function logDeposit() external {
        emit withdraw("deposit.", tx.origin);
    }

    function logWithdraw() external pure {
        revert("Failed to Re-Entrancy.");
    }
}

contract Attack {
    Bank public bank;

    constructor(Bank _bank){
        bank = Bank(_bank);
    }

    receive() external payable {
        if(address(msg.sender).balance>0) {
            bank.withdraw(1 ether);
        }
    }

    function attack() public payable { 
        bank.withdraw(1 ether);
    }

    function re() public payable {
        bank.deposit{value : 1 ether}();
    }
}