// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// 1. 숫자만 들어갈 수 있으며 길이가 4인 배열을 (상태변수로)선언하고 그 배열에 숫자를 넣는 함수를 구현하세요. 
// 배열을 초기화하는 함수도 구현하세요. (길이가 4가 되면 자동으로 초기화하는 기능)
// - 답안
contract bs1{
    uint[4] a;
    uint count;

    function bs11(uint _n) public returns(uint[4] memory) {
        if(count == 4) {
            for(uint i; i < count; i++){
                delete a[i];
            }
            count = 1;
            a[0] = _n;
            return a;
        } else {
            a[count] = _n;
            count ++;
            return a;
        }
    } 
}
// 1. 이름과 번호 그리고 지갑주소를 가진 '고객'이라는 구조체를 선언하세요. 
// 새로운 고객 정보를 만들 수 있는 함수도 구현하되 이름의 글자가 최소 5글자가 되게 설정하세요.
// - 답안
contract bs2{
    struct customer{
        string name;
        uint num;
        address addr;
    }
    customer[] public customers;
    
    uint customerCount = 1;

    function newCustomer(string calldata _name) public {
        bytes memory a = bytes(_name);
        require(a.length > 4,"Name length should be over 5.");
        customers.push() = customer(_name, ++customerCount, msg.sender);
    }
}
// 1. 은행의 역할을 하는 contract를 만드려고 합니다. 별도의 고객 등록 과정은 없습니다. 
// 해당 contract에 ether를 예치할 수 있는 기능을 만드세요. 또한, 자신이 현재 얼마를 예치했는지도 볼 수 있는 함수 
// 그리고 자신이 예치한만큼의 ether를 인출할 수 있는 기능을 구현하세요.
//     힌트 : mapping을 꼭 이용하세요.
contract bs3{
    receive() external payable{}

    address bank = address(this);
    
    mapping(address => uint) balance;

    function deposit(uint _amount) public payable {
        payable(bank).transfer(_amount);
        balance[msg.sender] = _amount;
    }

    function checkBalance() public view returns(uint){
        return balance[msg.sender];
    }

    function withdraw(uint _amount) public payable  {
        require(balance[msg.sender] > _amount,"Insufficient funds to make the withdrawal.");
        balance[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
    }
}
// 1. string만 들어가는 array를 만들되, 4글자 이상인 문자열만 들어갈 수 있게 구현하세요.
// - 답안
contract bs4{
    string[] array;

    function pushArray(string calldata _a) public {
        require(bytes(_a).length >= 4,"The word length should be over 4.");
        array.push(_a);
    }
}   
// 1. 숫자만 들어가는 array를 만들되, 100이하의 숫자만 들어갈 수 있게 구현하세요.
// - 답안
contract bs5{
    uint[] array;

    function pushArray(uint _n) public {
        require(_n <= 100,"Input number is should be less than 101");
        array.push(_n);
    }
}
// 1. 3의 배수이거나 10의 배수이면서 50보다 작은 수만 들어갈 수 있는 array를 구현하세요.
//     (예 : 15 -> 가능, 3의 배수 // 40 -> 가능, 10의 배수이면서 50보다 작음 // 66 -> 가능, 
//          3의 배수 // 70 -> 불가능 10의 배수이지만 50보다 큼)
// - 답안
contract bs6{
    uint[] public array;

    function pushArray(uint _n) public {
        require(_n % 3 == 0 || _n % 10 == 0 && _n < 50);
        array.push(_n);
    }
}
// 1. 배포와 함께 배포자가 owner로 설정되게 하세요. owner를 바꿀 수 있는 함수도 구현하되 그 함수는 owner만 실행할 수 있게 해주세요.
// - 답안
contract bs7{

    address owner;

    constructor(){
        owner = msg.sender;
    }

    function setOwner(address _addr) public {
        require(owner == msg.sender,"You are not Owner");
        owner = _addr; 
    }
}
// 1. A라는 contract에는 2개의 숫자를 더해주는 함수를 구현하세요. B라고 하는 contract를 따로 만든 후에 A의 더하기 함수를 사용하는 코드를 구현하세요.
// - 답안
contract bs8A{
    function add(uint _a, uint _b) public pure returns(uint){
        return _a + _b;
    }
}

contract bs8B{
    bs8A aa;

    function addbs8a(uint a, uint b) public view returns(uint){
        return aa.add(a,b);
    }
}
// 1. 긴 숫자를 넣었을 때, 마지막 3개의 숫자만 반환하는 함수를 구현하세요.
//     예) 459273 → 273 // 492871 → 871 // 92218 → 218
// - 답안
contract bs9 {
    function bs99(uint _n) public pure returns(uint){
        return _n % 1000;
    }
}
// 1. 숫자 3개가 부여되면 그 3개의 숫자를 이어붙여서 반환하는 함수를 구현하세요. 
//     예) 3,1,6 → 316 // 1,9,3 → 193 // 0,1,5 → 15 
//     응용 문제 : 3개 아닌 n개의 숫자 이어붙이기
contract bs10 {
    function bsbs(uint a, uint b, uint c) public pure returns(uint){
        return(a*100+b*10+c);
    }
}