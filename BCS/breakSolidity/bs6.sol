// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// 1. a의 b승을 반환하는 함수를 구현하세요.
// - 답안
contract bs1{
    function bs11(uint a, uint b) public pure returns(uint){
        return a ** b;
    }
}

// 1. 2개의 숫자를 더하는 함수, 곱하는 함수 a의 b승을 반환하는 함수를 구현하는데 3개의 함수 모두 2개의
// input값이 10을 넘지 않아야 하는 조건을 최대한 효율적으로 구현하세요.
// - 답안
contract bs2{
    function bs22(uint a, uint b) public pure returns(uint,uint,uint){
        require(a < 10 && b < 10);
        return (a+b,a*b,a**b);
    }
}
    
// 1. 2개 숫자의 차를 나타내는 함수를 구현하세요.
// - 답안
contract bs3 {
    function bs33(uint a, uint b) public pure returns(uint){
        return a-b;
    }
}
    
// 1. 지갑 주소를 넣으면 5개의 4bytes로 분할하여 반환해주는 함수를 구현하세요.
// - 답안
contract bs4 {
    function bs44(address a) public pure returns(bytes4) {
        // bytes4[] memory splitBytes = new bytes4[](5);

        // for (uint i = 0; i < 5; i++) {
        //     splitBytes[i] = bytes4
        // }

        // return splitBytes;
    }
}

// 1. 숫자 3개를 입력하면 그 제곱을 반환하는 함수를 구현하세요. 
// 그 3개 중에서 가운데 출력값만 반환하는 함수를 구현하세요.
//     예) func A : input → 1,2,3 // output → 1,4,9 | func B : output 4 (1,4,9중 가운데 숫자) 
// - 답안
contract bs5 {
    uint aaa;

    function bs55(uint a, uint b, uint c) public returns(uint,uint,uint){
        aaa = b**b;
        return (a**a, b**b, c**c);
    }
    function bs552() public view returns(uint){
        return aaa;
    }
}
    
// 1. 특정 숫자를 입력했을 때 자릿수를 알려주는 함수를 구현하세요. 
// 추가로 그 숫자를 5진수로 표현했을 때는 몇자리 숫자가 될 지 알려주는 함수도 구현하세요.
// - 답안
contract bs6{
    function bs66(uint a) public pure returns(uint){
        uint k;
        while(a >= 10){
            a /= 10;
            k += 1;
        }
        return k+1;
    }

    function bs662(uint a) public pure returns(uint){
        uint k;
        uint l;
        while(a >= 5){
            a /= 5;
            k += 1;
        }
        return k+1;
    }
}
    
// 1. 자신의 현재 잔고를 반환하는 함수를 보유한 Contract A와 
// 다른 주소로 돈을 보낼 수 있는 Contract B를 구현하세요.
//     B의 함수를 이용하여 A에게 전송하고 A의 잔고 변화를 확인하세요.
// - 답안
contract bs7{
    receive() external payable{}
    function bs77() public view returns(uint){
        return address(this).balance;
    }
}
contract bs72{
    address bs77;
    constructor(address a){
        bs77 = a;
    }
    function bs772() public payable {
        payable(bs77).transfer(msg.value);
    }
}
    
// 1. 계승(팩토리얼)을 구하는 함수를 구현하세요. 계승은 그 숫자와 같거나 작은 모든 수들을 곱한 값이다. 
//     예) 5 → 1*2*3*4*5 = 60, 11 → 1*2*3*4*5*6*7*8*9*10*11 = 39916800
//     while을 사용해보세요
// - 답안
contract bs8{
    function bs88(uint a) public pure returns(uint){
        uint k = 1;
        uint i;
        while(a > i){
            i++;
            k *= i;
        }
        return k;
    }
}

// 1. 숫자 1,2,3을 넣으면 1 and 2 or c 라고 반환해주는 함수를 구현하세요.
//     힌트 : 7번 문제(시,분,초로 변환하기)
// - 답안


contract bs9{
    function bs99(uint a, uint b, uint c) public pure returns(string memory){
        return string(abi.encodePacked(concat(a)," and ",concat(b)," or ",concat(c)));
    }

    function concat(uint a) internal pure returns(string memory){
        uint length = getlength(a);
        uint[] memory num = new uint[](length);
        num = divide(a);
        for(uint i; i < length; i++){
            num[i] += 48;
        }
        return string(abi.encodePacked(num));
    }

    function divide(uint a) internal pure returns(uint[] memory){
        uint[] memory aa = new uint[](getlength(a));
        uint i = getlength(a);
        while(a !=0){
            aa[--i] = a % 10;
            a /= 10;
        }
        return aa;
    }

    function getlength(uint a) internal pure returns(uint){
        uint k;
        while(a > 10){
            a /= 10;
            k += 1;
        }
        return k+1;
    }

    function dividea(uint a) public pure returns(uint[] memory){
        uint[] memory aa = new uint[](getlength(a));
        uint i = getlength(a);
        while(a != 0){
            aa[--i] = a % 10;
            a /= 10;
        }
        return aa;
    }

    function concata(uint a) public pure returns(string memory){
        uint[] memory aa = new uint[](getlength(a));
        aa = dividea(a);
        for(uint i ; i < getlength(a); i++){
            aa[i] += 48;
        }
        return string(abi.encodePacked(aa));
    }
}
    
// 1. 번호와 이름 그리고 bytes로 구성된 고객이라는 구조체를 만드세요. 
//bytes는 번호와 이름을 keccak 함수의 input 값으로 넣어 나온 output값입니다. 
//고객의 정보를 넣고 변화시키는 함수를 구현하세요
contract bs10{
    struct customer {
        uint num;
        string name;
        bytes32 output;
    }

    customer public customers;

    function bs101(uint num, string calldata name) public {
        bytes32 x = keccak256(abi.encodePacked(num, name));
        customers = customer(num, name, x);
    }
}