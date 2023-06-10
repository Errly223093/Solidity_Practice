// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// 1. 숫자들이 들어가는 배열을 선언하고 그 중에서 3번째로 큰 수를 반환하세요.
// - 답안
contract bs1 {
    uint[] arr = [5,3,4,2,0];

    function bs11() public view returns(uint){
        uint[] memory array = arr;

        for(uint i; i < array.length-1; i++){
            for(uint j=i+1; j < array.length; j++){
                if(array[j] > array[i]){
                    (array[i], array[j]) = (array[j], array[i]);
                }
            }
        }
        return array[2];
    }
}

    
// 1. 자동으로 아이디를 만들어주는 함수를 구현하세요. 이름, 생일, 지갑주소를 기반으로 만든 해시값의 첫 10바이트를 추출하여 아이디로 만드시오.
// - 답안
contract bs2 {
    bytes10 public ID;
    
    function bs22(string memory _name, uint _birth, address _addr) public returns(bytes10) {
       ID = bytes10(keccak256(abi.encodePacked(_name,_birth,_addr)));
    }
}

// 1. 시중에는 A,B,C,D,E 5개의 은행이 있습니다. 각 은행에 고객들은 마음대로 입금하고 인출할 수 있습니다.
//  각 은행에 예치된 금액 확인, 입금과 인출할 수 있는 기능을 구현하세요. 힌트 : 이중 mapping을 꼭 이용하세요.
// - 답안
contract bs3 {
    mapping(string => mapping(address => uint)) private balance; // 은행코드 => 지갑주소 => 발란스
    address payable public CA = payable(address(this));

    function getMyBalance(string calldata _bank) public view returns(uint) {
        return balance[_bank][msg.sender];
    }

    function deposit(string calldata _bank, uint _amount) public payable {
        balance[_bank][msg.sender] += msg.value;
    }
    function withdraw(string calldata _bank, uint _amount) public payable {
        balance[_bank][msg.sender] -= _amount; 
        payable(msg.sender).transfer(_amount);
    }
}
    
// 1. 기부받는 플랫폼을 만드세요. 가장 많이 기부하는 사람을 나타내는 변수와 그 변수를 지속적으로 바꿔주는 함수를 만드세요
//     힌트 : 굳이 mapping을 만들 필요는 없습니다.
// - 답안
contract bs4 {
    address numberOne;
    uint donate;
    function updateNumberOne() public payable {
        if(msg.value > donate){
            numberOne = msg.sender;
            donate = msg.value;
        }
    }
}
    
// 1. 배포와 함께 owner를 설정하고 owner를 다른 주소로 바꾸는 것은 오직 owner 스스로만 할 수 있게 하십시오.
// - 답안
contract bs5 {
    address private owner;
    constructor(){
        owner = msg.sender;
    }
    function setOwner(address _newOwnerAddr) public {
        require(owner == msg.sender);
        owner = _newOwnerAddr;
    }
}
    
// 1. 위 문제의 확장버전입니다. owner와 sub_owner를 설정하고 owner를 바꾸기 위해서는 둘의 동의가 모두 필요하게 구현하세요.
// - 답안
contract bs6 {
    address private owner;
    address private sub_owner;
    constructor(address subOwner){
        owner = msg.sender;
        sub_owner = subOwner;
    }
    bool sub_owner_agree;

    function set_sub_owner_agree_true() public {
        require(sub_owner == msg.sender);
        sub_owner_agree = true;
    }

    function setOwner(address _newOwnerAddr) public {
        require(owner == msg.sender && sub_owner_agree == true);
        owner = _newOwnerAddr;
    }
}

// 1. 위 문제의 또다른 버전입니다. owner가 변경할 때는 바로 변경가능하게 sub-owner가 변경하려고 한다면 owner의 동의가 필요하게 구현하세요.
// - 답안
contract bs7 {
    address private owner;
    address private sub_owner;
    constructor(address subOwner){
        owner = msg.sender;
        sub_owner = subOwner;
    }

    bool owner_agree;

    function set_owner_agree_true() public {
        require(owner == msg.sender);
        owner_agree = true;
    }

    function setOwner(address _newOwnerAddr) public {
        require(owner == msg.sender || owner_agree == true && msg.sender == sub_owner);
        owner = _newOwnerAddr;
    }
}

// 1. A contract에 a,b,c라는 상태변수가 있습니다. 
// a는 A 외부에서는 변화할 수 없게 하고 싶습니다. 
// b는 상속받은 contract들만 변경시킬 수 있습니다. 
// c는 제한이 없습니다. 
// 각 변수들의 visibility를 설정하세요.
// - 답안
contract bs8 {
    uint private a;
    uint internal b;
    uint public c;
}
    
// 1. 현재시간을 받고 2일 후의 시간을 설정하는 함수를 같이 구현하세요.
// - 답안
contract bs9 {
    uint public time;
    function setTime() public returns(uint) {
        time = block.timestamp + 2 days;
        return block.timestamp;
    }
}
    
// 1. 방이 2개 밖에 없는 펜션을 여러분이 운영합니다. 각 방마다 한번에 3명 이상 투숙객이 있을 수는 없습니다. 
// 특정 날짜에 특정 방에 누가 투숙했는지 알려주는 자료구조와 그 자료구조로부터 값을 얻어오는 함수를 구현하세요.
//     예약시스템은 운영하지 않아도 됩니다. 과거의 일만 기록한다고 생각하세요.
//     힌트 : 날짜는 그냥 숫자로 기입하세요. 예) 2023년 5월 27일 → 230527
contract bs10 {
    mapping(uint => mapping(uint => string[])) public log;

    function pushLog(uint date, uint room, string[] memory name) public {
        log[date][room] = name;
    }

    function getLog(uint date, uint room) public returns(string[] memory) {
        return log[date][room];
    }
}