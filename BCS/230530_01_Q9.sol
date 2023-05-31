// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@openzeppelin/contracts/utils/Strings.sol";

contract test {
    // 흔히들 비밀번호 만들 때 대소문자 숫자가 각각 1개씩은 포함되어 있어야 한다 등의 조건이 붙는 경우가 있습니다. 
    // 그러한 조건을 구현하세요.
    // 입력값을 받으면 그 입력값 안에 대문자, 소문자 그리고 숫자가 최소한 1개씩은 포함되어 있는지 
    // 여부를 알려주는 함수를 구현하세요.


        function q1(string memory _pw) public pure returns(bool) {
            // require(bytes32(abi.encodePacked(_pw)) > bytes32(abi.encodePacked("A")) || bytes32(abi.encodePacked(_pw)) < bytes32(abi.encodePacked("Z")));
            // return bytes32(abi.encodePacked(_pw));

            bytes memory pw = bytes(_pw);
            uint pwLength = pw.length;

            bool upper;
            bool num;
            bool lower;

            for(uint i; i < pwLength; i++){
                if(pw[i] >= 0x41 && pw[i] <= 0x5a){
                    upper = true;
                }
                if(pw[i] >= 0x30 && pw[i] <= 0x39){
                    num = true;
                }
                if(pw[i] >= 0x61 && pw[i] <= 0x7a){
                    lower = true;
                }
            }

            require(upper && num && lower);
            return true;
    }
}

        // bytes memory temp = bytes( _input ) ;
        // uint length = temp.length ;

        // bool number = false ; // 숫자
        // bool L = false ; // 대문자
        // bool l = false ; // 소문자

        // for( uint i = 0 ; i < length ; i ++ ) {

        //     if( !number && uint8( temp[ i ] ) >= uint8( bytes1( '0' ) ) && uint8( temp[ i ] ) <= uint8( bytes1( '9' ) ) ) number = true ;
        //     if( !L && uint8( temp[ i ] ) >= uint8( bytes1( 'A' ) ) && uint8( temp[ i ] ) <= uint8( bytes1( 'Z' ) ) ) L = true ;
        //     if( !l && uint8( temp[ i ] ) >= uint8( bytes1( 'a' ) ) && uint8( temp[ i ] ) <= uint8( bytes1( 'z' ) ) ) l = true ;
        //     if( number && L && l ) return true ;

        // return ( number && L && l ) ;   
