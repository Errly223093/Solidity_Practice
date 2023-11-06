// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

/*

Multi Signature Wallet
여러 주소가 Multi Signature Wallet 의 공동 owner 가 된다.
owner 들이 설정한 만큼 approve(confirm) 된 tx 는 실행이 가능하다.

- 테스트
TestContract 의 함수 callMe 호출하기

1. 주소 3개를 아래 그대로 복사해서 생성자의 주소로, numberOfConfirmRequired 는 2로 배포.
["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4","0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2","0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db"]

2. TestContract 배포. 원하는 값을 넣고 getData 함수 실행, bytes 값 반환

3. submit 함수 call. (TestContract 주소, value = 0, bytes = 위에 2번에서 얻은 bytes 값)

4. txId 0번을 tx를 지갑을 돌려가며 approve 한다.(1에서 설정한대로 2번 이상 approve)

5. txId 0번을 execution 한다. TestContract 의 i 값이 변경되었는지 확인.

*/

contract MultiSignatureWallet {
    event Deposit(address indexed sender, uint value, uint balance);
    event SubmitTransaction(
        address indexed owner,
        uint indexed txIndex,
        address indexed to,
        uint value,
        bytes data
    );
    event Approve(address indexed owner, uint txId);
    event Revoke(address indexed owner, uint txId);
    event Execute(address indexed owner, uint txId);

    struct Transaction {
        address to;
        uint value;
        bytes data;
        bool executed;
        uint confirmation;
    }

    Transaction[] public transactions;
    uint public numberOfConfirmRequired;
    address[] public owners;
    mapping(address => bool) isOwner;
    mapping(uint => mapping(address => bool)) public isApproved;

    // receive 로 받는 이더를 emit 처리
    receive() external payable {
        emit Deposit(msg.sender, msg.value, address(this).balance);
    }

    // owner 주소를 배열로 처리, 최소 approve 요구 값을 생성자로 설정
    constructor(address[] memory _owners, uint _numberOfConfirmRequired) {
        require(_numberOfConfirmRequired != 0 
        && _numberOfConfirmRequired <= _owners.length,"Invaild confirm number.");
        require(_owners.length > 1,"Minimum two addresses are required.");

        for(uint i; i < _owners.length; i++){
            require(_owners[i] != address(0),"Zero address.");
            require(!isOwner[_owners[i]],"Invaild address");
            owners.push(_owners[i]);
            isOwner[_owners[i]] = true;
        }
        numberOfConfirmRequired = _numberOfConfirmRequired;
    }

    // 지정된 owner 인가?
    modifier onlyOwner() {
        require(isOwner[msg.sender], "Owner only.");
        _;
    }

    // tx 가 실행되지 않았는가?
    modifier checkExecute(uint _txId) {
        require(!transactions[_txId].executed, "Already executed.");
        _;
    }

    // msg.sender 가 특정 tx 를 approve 를 하지 않았는가?
    modifier checkApprove(uint _txId) {
        require(!isApproved[_txId][msg.sender], "Already approved.");
        _;
    }

    // 존재하는 tx 인가?
    modifier txExist(uint _txId) {
        require(_txId <= transactions.length, "Already Executed.");
        _;
    }

    // tx 제출. 다른 지갑의 approve 를 기다리게 됨.
    function submit(address _to, uint _value, bytes memory _data) external onlyOwner {
        require(_to != address(0), "Zero address.");
        require(_value != 0 || _data.length != 0, "Invaild input.");
        transactions.push(Transaction(_to, _value, _data, false, 0));
        emit SubmitTransaction(msg.sender, transactions.length -1, _to, _value, _data);
    }

    // submit 된 tx Approve
    function approve(uint _txId) 
        external 
        onlyOwner 
        checkApprove(_txId) 
        checkExecute(_txId)
        txExist(_txId)
    {
        isApproved[_txId][msg.sender] = true;
        transactions[_txId].confirmation += 1;
        emit Approve(msg.sender, _txId);
    }

    // Approve 했던 tx 취소
    function revoke(uint _txId)
        external 
        onlyOwner
        checkExecute(_txId)
        txExist(_txId)
    {
        require(isApproved[_txId][msg.sender], "Not approved.");
        
        isApproved[_txId][msg.sender] = false;
        transactions[_txId].confirmation -= 1;
        emit Revoke(msg.sender, _txId);
    }

    //   gas   tx   execute ------ 가스비 비교(지역변수X)
    // 105763 91967 70763 
    // 86123 74889 53685
    function execution(uint _txId) 
        external
        onlyOwner
        txExist(_txId)
    {
        // 지역변수 사용없이는 가스비 소모가 심함.
        require(!transactions[_txId].executed, "Already executed.");
        require(numberOfConfirmRequired <= transactions[_txId].confirmation,"Not Approved.");
        
        // re-entry 할 수 없도록 상태변수 변경 후 call
        transactions[_txId].executed = true;
        (bool success, ) = transactions[_txId].to.call
        {value : transactions[_txId].value}(transactions[_txId].data);
        require(success, "Failed to transact.");
        emit Execute(msg.sender, _txId);
    }

    //   gas   tx   execute ------ 가스비 비교(지역변수O storage)
    // 104717 91058 69866
    // 85066 73970 52766
    function execution_2(uint _txId) 
        external
        onlyOwner
        txExist(_txId)
    {
        // storage 를 사용한 지역변수는 가스비 소모가 심함.
        Transaction storage transaction = transactions[_txId];
        require(!transaction.executed, "Already executed.");
        require(numberOfConfirmRequired <= transaction.confirmation,"Not Approved.");

        // re-entry 할 수 없도록 상태변수 변경 후 call
        transaction.executed = true;
        (bool success, ) = transaction.to.call
        {value : transaction.value}(transaction.data);
        require(success, "Failed to transact.");
        emit Execute(msg.sender, _txId);
    }

    //   gas  tx  execute ------ 가스비 비교(지역변수O memory)
    // 62611 54444 33240
    // 62611 54444 33240
    function execution_3(uint _txId) 
        external
        onlyOwner
        txExist(_txId)
    {
        // memory 형태의 지역변수 사용으로 가스비 절약
        Transaction memory transaction = transactions[_txId];
        require(!transaction.executed, "Already executed.");
        require(numberOfConfirmRequired <= transaction.confirmation,"Not Approved.");

        // re-entry 할 수 없도록 상태변수 변경 후 call
        transaction.executed = true;
        (bool success, ) = transaction.to.call
        {value : transaction.value}(transaction.data);
        require(success, "Failed to transact.");
        emit Execute(msg.sender, _txId);
    }

    // 가장 최근의 txId 를 반환
    function getTxCount() public view returns(uint){
        return transactions.length;
    }
}

contract TestContract {
    uint public i;

    function callMe(uint j) public {
        i += j;
    }

    // function Selector 역할. 원하는 함수와 인자를 묶어서 bytes 코드로 변환
    function getData(uint _num) public pure returns (bytes memory) {
        return abi.encodeWithSignature("callMe(uint256)", _num);
    }
}



