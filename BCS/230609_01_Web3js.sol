// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract AAA {
  uint public a = 100;

  function setA(uint _a) public {
    a = _a;
  }

  function add(uint _a, uint _b) public pure returns(uint) {
    return _a+_b;
  }
}

  // 준비작업
  // mkdir web3 // 폴더생성. 적절한 위치에 만들기
  // cd web3
  // npm init
  // ls // package.json 생성 확인
  // npm install web3
  // node // node 환경으로 이동
  // var {Web3} = require('web3')
  // var web3 = new Web3('위에서 발급받은 infura 의 API 가져오기. https://~~~~')
  // web3 // 다양한 기능 확인 가능
  // web3.provider // 위의 cloudflare 잘 나오는지 확인


  // 활용방법
  
  // 현재 블록넘버
  // web3.eth.getBlockNumber().then(console.log)

  // 100000 번째 블록의 데이터
  // web3.eth.getBlock(100000).then(console.log)

  // 지갑의 잔고
  // web3.eth.getBalance('지갑주소').then(console.log)

  // 트랜잭션 데이터
  // web3.eth.getTransaction('트랜잭션 해시값').then(console.log)

  // 지갑 생성. 개인키와 공개키를 반환해줌
  // web3.eth.accounts.create()

  // 개인키를 입력하면 지갑주소를 반환
  // web3.eth.accounts.privateKeyToAccount('0x - 개인키')

  // 100000 번째 블록의 트랜잭션 수
  // web3.eth.getBlockTransactionCount(1000000).then(console.log)

  // n 번째 블록의 n 번째 트랜잭션 데이터 가져오기
  // web3.eth.getTransactionFromBlock('BLOCK NUMBER', 'INDEX').then(console.log)
