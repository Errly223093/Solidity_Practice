// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import '@openzeppelin/contracts/utils/Strings.sol';

contract C {
    function utos(uint _n) public pure returns(string memory) {
        return Strings.toString(_n);
    }
}

// import 는 외부에서. 라이브러리는 특별한 컨트랙트 형태라고 볼 수 있다.
// 라이브러리에 접근할땐 pure 가능.