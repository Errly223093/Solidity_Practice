// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

/*
struct , mapping 상태변수를 접근하는 방법(truffle console)

Struct
hash => web3.utils.soliditySha3({type: "uint", value : slot넘버})

Struct 의 첫 번째 변수 => web3.eth.getStorageAt(addr, hash, console.log)

Struct 의 두 번째 변수 => web3.eth.getStorageAt(addr, hash+1, console.log)

Struct 의 세 번째 변수 => web3.eth.getStorageAt(addr, hash+2, console.log) ...

mapping
hash => web3.utils.soliditySha3({type: "uint", value : mapping key}, {type: "uint", value : slot넘버})

mapping struct 의 첫 번째 변수 => web3.eth.getStorageAt(addr, hash, console.log)

mapping struct 의 두 번째 변수 => web3.eth.getStorageAt(addr, hash +1, console.log)

mapping struct 의 세 번째 변수 => web3.eth.getStorageAt(addr, hash +2, console.log)

자세한 내용은 https://velog.io/@lmjgmm/Solidity-Accessing-Private-Data
*/

contract accountDB {
    // slot 0
    uint public count = 123; // 32 bytes (2**8) * 32

    // slot 1
    address public owner = msg.sender; // 20 bytes (2**8) * 20
    bool public isTrue = true; // 1 byte
    uint16 public u16 = 30; // 2 bytes (2**8) * 2

    // slot 2
    bytes32 private password;

    // constant 는 slot 에 저장되지 않음.
    uint public constant someConst = 123;

    // slot 3, 4, 5 (하나의 슬롯당 하나의 배열 자리를 차지함)
    bytes32[3] public data;

    /* 
    slot 6 - 배열의 길이
    슬롯에 배열의 요소가 저장됨 어디에? => keccak256(slot 넘버)
    */
    struct User {
        uint id;
        bytes32 password;
    }
    User[] private users;

    /* 
    slot 7
    슬롯 7 맵핑의 슬롯 => keccak256(mapping key, slot 넘버)
    */
    mapping(uint => User) private idToUser;

    constructor(bytes32 _password) {
        password = _password;
    }

    function addUser(bytes32 _password) public {
        User memory user = User({
            id: users.length,
            password: _password
        });
        users.push(user);
        idToUser[user.id] = user;
    }

    function getArrayLocation(uint slot, uint index, uint elementSize) public pure returns(uint){
        return uint(keccak256(abi.encodePacked(slot))) + (index + elementSize);
    }

    function getMapLocation(uint slot, uint key) public pure returns(uint){
        return uint(keccak256(abi.encodePacked(slot, key)));
    }
}