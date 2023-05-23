// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract multipleMapping {
    struct user {
        uint number;
        string name;
    }

    uint[] A;
    user B;

    mapping(address=>uint) balance;
    mapping(address=>mapping(string=>uint)) bankAccounts;

    mapping(address=>mapping(string=>user)) bankAccounts2; /*struct와 같은 refernce type 변수는 오직 value로만 사용가능*/
    mapping(string=>mapping(string=>mapping(uint=>user))) bankAccounts3;
    mapping(address=>uint[]) As;

    mapping(address=>mapping(abc=>uint)) structmapping;
    // mapping(uint[]=>address) As2; /*array역시 key로는 사용할 수 없음*/

    function setBalance() public {
        balance[msg.sender] = (msg.sender).balance;
    }

    function setBankAccounts(string calldata _name) public {
        bankAccounts[msg.sender][_name] = 100;
    }

    function setBankAccounts2(string calldata _city, string calldata _state, uint number) public {
        bankAccounts3[_city][_state][number] = B;
    }

    function getbankAccounts(address _addr, string calldata _name) public view returns(uint) {
        return bankAccounts[_addr][_name];
    }
}

contract abc{

    enum food {
        chicken,
        pizza,
        water
    }

    mapping(address=>mapping(abc=>uint)) contractmapping;
    mapping(address=>mapping(food=>uint)) enummapping;
}

contract test{
    uint public a = 4;
}