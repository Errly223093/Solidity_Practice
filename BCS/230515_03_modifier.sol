// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract modifier1{
    uint a;

    modifier lessthanfive(){
        require(a<5, "sholud be less than five");
        _; // 함수가 실행되는 시점.
    }

    function aplus() public {
        a++;
    }

    function aminus() public {
        a--;
    }

    function getA() public view returns(uint) {
        return a;
    }

    function doubleA() public lessthanfive{
        a = a*2;
    }

    function plusten() public lessthanfive{
        a += 10;
    }
}

contract modifier2 {
    uint a;

    modifier plusonebefore() {
        _;
        a++;
    }

    modifier plusoneafter() {
        a++;
        _;
    }

    function setA() public plusonebefore returns (string memory){
        if(a>=3){
            return "a";
        } else {
            return "b";
        }
    }

        function setA2() public plusoneafter returns (string memory){
        if(a>=3){
            return "a";
        } else {
            return "b";
        }
    }

    function getA() public view returns(uint){
        return a;
    }

    function setAas2()public {
        a = 2;
    }
}

contract modifier3 {
    struct person {
        uint age;
        string name;
    }

    person P;

    modifier overtwenty(uint _age) {
        require(20 <= _age);
        _;
    }

    function buycigar(uint _a) public overtwenty(_a) pure returns(bool) {
        return true;
    }

    function buyalcho(uint _a) public overtwenty(_a) returns(string memory) {
        return "pass";
    }

    function buygu(uint _a) public overtwenty(_a) returns(string memory) {
        return "pass";
    }
}

contract modifier4 {
    struct Person {
        uint age;
        string name;
    }

    Person P;

    modifier overTwenty(uint _age, string memory _criminal) {
        require(_age >20, "Too young");
        require(keccak256(abi.encodePacked(_criminal)) != keccak256(abi.encodePacked("Bob")), "Bob is criminal. She can't buy it");
        _;
    }

    function buyCigar(uint _a, string memory _name) public pure overTwenty(_a, _name) returns(string memory) {
        return "Passed";
    }

    function buyAlcho(uint _a, string memory _name) public pure overTwenty(_a, _name) returns(string memory) {
        return "Passed";
    }

    function buyGun(uint _a, string memory _name) public pure overTwenty(_a, _name) returns(string memory) {
        return "Passed";
    }

    function setP(uint _age, string memory _name) public {
        P = Person(_age, _name);
    }

    function getP() public view returns(Person memory) {
        return P;
    }

    function buyCigar2() public overTwenty(P.age, P.name) view returns(string memory) {
        return "Passed";
    }

    function buyAlcho2() public overTwenty(P.age, P.name) view returns(string memory) {
        return "Passed";
    }

    function buyGu2() public overTwenty(P.age, P.name) view returns(string memory) {
        return "Passed";
    }

}

contract modifier5 {
    uint mutex;

    modifier m_check {
        mutex++;
        _;
        mutex--;
    }

    modifier shouldbezero {
        require(mutex == 0, "someone is using");
        _;
    }

    function inandout() public m_check returns(string memory) {
        return "done";
    }

    function occupy() public {
        mutex ++;

    }

    function vacancy() public {
        mutex --;
    }


}

contract checkModifier{

    uint a = 6;

    modifier checkA {
        require(a > 5, "please check A value.");
        _;
    }

    function minusA() checkA public {
        a--;
    }

    function getA() public view returns(uint){
        return a;
    }
}