// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.18;

contract Address {
    address a;

    function getAddress() public view returns(address) {
        return address(this);
    }

    function getMyAccount() public view returns(address) {
        return address(msg.sender);
    }

    function getMyBalance() public view returns(uint) {
        return address(msg.sender).balance;
    }

    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }

}

contract Mapping {
    mapping(uint => uint) a; // key-value 쌍이 숫자-숫자로 연결되어 있는 a
    mapping(uint => string) b;
    mapping(string => address) c;

    mapping(uint => mapping(string => uint)) score; // 1 반의 john 의 점수를 가져올때 이중매핑

    // 이름을 검색하면 그 아이의 키를 반환받는 contract 를 구현하고 싶다.1
    mapping(string => uint) height;

    // 정보 넣기
    function setHeight(string memory _name, uint _h) public {
        height[_name] = _h; // mapping이름 [key] = value;
    }

    // 정보 받기
    function getHeight(string memory _name) public view returns(uint) {
        return height[_name];
    }

    
    
}
