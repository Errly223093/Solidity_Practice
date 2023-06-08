// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract q8 {
    // 로또 프로그램을 만드려고 합니다. 
    // 숫자와 문자는 각각 4개 2개를 뽑습니다. 
    // 6개가 맞으면 1이더, 
    // 5개의 숫자가 순서와 함께 맞으면 0.75이더, 
    // 4개가 맞으면 0.25이더, 
    // 3개가 맞으면 0.1이더 
    // 2개 이하는 상금이 없습니다. 

    // 참가 금액은 0.05이더이다.
               // 3,4,8,1,C,Z
    // 기준 숫자 : 1,2,3,4,A,B
    // -----------------------------------------------------------------
    // 기준 숫자 설정 기능 : 5명의 사람이 임의적으로 4개의 숫자와 2개의 문자를 넣음. 
    // 5명이 넣은 숫자들의 중앙값과 알파벳 순으로 따졌을 때 가장 가운데 문자로 설정
    // 예) 숫자들의 중앙값 : 1,3,6,8,9 -> 6 // 2,3,4,8,9 -> 4
    // 예) 문자들의 중앙값 : a,b,e,h,l -> e // a,h,i,q,z -> i
    string[] lottoNum;
    address owner;

    constructor() {
        lottoNum = ["1","2","3","4","A","B"]; // 첫 기준 숫자를 셋팅.
        owner = msg.sender;
    }
    receive() external payable{}

    function startLotto(string[] calldata _n) public payable returns(uint) {

        //require(msg.value == 0.05 ether,"Game fee is 0.05 ether."); // 0.05 ether 체크
        //require(_n.length == 6,"Please check your Lotto Count. it sholud be 6.");
        // 인풋 값이 6개 인지 확인. 에러 처리를 위해 req 두줄 사용.
        // payable(address(this)).transfer(0.05 ether);

        uint score;

        for(uint i; i < _n.length; i++){ // 로또 번호를 하나씩 대조해서 맞다면 score ++
            for(uint j; j < _n.length; j++){
                if(keccak256(abi.encodePacked(lottoNum[i])) == keccak256(abi.encodePacked(_n[j]))){
                    score++;
                }
            }
        }
        
        if(score == 6){ // 점수를 확인해서 상금을 전송해줌. or 상금 수령 함수로 따로 빼도 됨.
            payable(msg.sender).transfer(1 ether);
        } else if(score == 5){
            payable(msg.sender).transfer(0.75 ether);
        } else if(score == 4){
            payable(msg.sender).transfer(0.5 ether);
        } else if(score == 3){
            payable(msg.sender).transfer(0.1 ether);
        }
        return score;
    }
}