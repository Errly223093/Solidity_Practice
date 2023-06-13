// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract multiarray{
    uint[][] public double_A;

    function setNumber(uint _a) public {
        double_A.push([_a]);
    }

    function setNumber2(uint _a, uint _b)public {
        double_A.push([_a, _b]);
    }

    function setNumber3(uint[] memory _a)public {
        double_A.push(_a);
    }

    function setNumber4(uint _a, uint _b, uint _c) public {
        double_A[_a][_b] = _c;
    }
}