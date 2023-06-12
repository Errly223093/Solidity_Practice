// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract event_emit_two {
    event ADD(string add, uint result);
    event SUB(string sub, uint result);
    event MUL(string mul, uint result);
    event DIV(string div, uint result);

    function add(uint a, uint b) public returns(uint c){
        c = a + b;
        emit ADD("Added", c);
        // pure , view 는 emit 불가능.
    }

        function sub(uint a, uint b) public returns(uint c){
        c = a + b;
        emit SUB("sub", c);
        // pure , view 는 emit 불가능.
    }

        function mul(uint a, uint b) public returns(uint c){
        c = a + b;
        emit MUL("mul", c);
        // pure , view 는 emit 불가능.
    }

        function div(uint a, uint b) public returns(uint c){
        c = a + b;
        emit DIV("div", c);
        // pure , view 는 emit 불가능.
    }
}