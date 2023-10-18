// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

/*
    Hoo 컨트랙트가 Hi 컨트랙트를 인스턴스화 하는듯 보이지만,
    실제론 다른 주소 값을 넣어도 됨. (Others 컨트랙트 주소로 배포 후 확인하기)

    외부 컨트랙트를 사용할 때, 올바른 주소인지 확인.
    알 수 없는 주소인 경우, 이더스캔을 통해 컨트랙트 세부 데이터를 확인.
    이더스캔의 특정 컨트랙트 주소에 확인 마크가 있다면 안전.
*/

contract Hi{
    event log(string message);

    function callEmit() external {
        emit log("this is Hi contract.");
    }
}

contract Hoo{
    Hi hi;

    constructor(Hi _hi){
        hi = Hi(_hi);
    }

    function callHi() external {
        hi.callEmit();
    }
}

contract Others{
    event log(string message);

    function callEmit() external {
        emit log("this is Others contract.");
    }
}