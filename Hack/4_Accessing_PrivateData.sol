// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

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
    슬롯은 keccak256(6) 으로 시작함
    슬롯에 배열의 요소가 저장됨 어디에? => keccak256(slot 넘버) + (인덱스 + 요소의 크기)
    슬롯 6 | 요소 크기 2 = 1(uint) + 1(bytes32)
    */
    struct User {
        uint id;
        bytes32 password;
    }
    User[] private users;

    /* 
    slot 7
    슬롯 7 맵핑의 슬롯 => keccak256(mapping key, 7)
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