// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// 숫자를 넣었을 때 그 숫자의 자릿수와 각 자릿수의 숫자를 나열한 결과를 반환하세요.
// 예) 2 -> 1,   2 // 45 -> 2,   4,5 // 539 -> 3,   5,3,9 // 28712 -> 5,   2,8,7,1,2
// --------------------------------------------------------------------------------------------
// 문자열을 넣었을 때 그 문자열의 자릿수와 문자열을 한 글자씩 분리한 결과를 반환하세요.
// 예) abde -> 4,   a,b,d,e // fkeadf -> 6,   f,k,e,a,d,f

contract test{
    function count(uint _n) public pure returns(bytes1) {
        uint a = _n;
        bytes32 c;

        c = bytes32(a);

        return c[1];
    }
}


pragma solidity ^0.8.0;

/*

숫자를 넣었을 때 그 숫자의 자릿수와 각 자릿수의 숫자를 나열한 결과를 반환하세요.
예) 2 -> 1,   2 // 45 -> 2,   4,5 // 539 -> 3,   5,3,9 // 28712 -> 5,   2,8,7,1,2
--------------------------------------------------------------------------------------------
문자열을 넣었을 때 그 문자열의 자릿수와 문자열을 한 글자씩 분리한 결과를 반환하세요.
예) abde -> 4,   a,b,d,e // fkeadf -> 6,   f,k,e,a,d,f
*/

// contract test {

//     function A( uint _input ) public pure returns( uint , uint[] memory ) {

//         uint x = 0 ;
//         uint temp = _input ;

//         for( ; temp > 0 ; ){
//         // for( ; temp ; ) 안됨.
//         // uint > bool 자동변환이 안되는듯?

//             x ++ ;
//             temp /= 10 ;

//         }

//         uint[] memory rt_value = new uint[]( x ) ;

//         for( ; _input > 0 ; ) {

//             rt_value[ -- x ] = _input % 10 ;
//             _input /= 10 ;

//         }

//         return ( rt_value.length , rt_value ) ;

//     }

//     function B( string memory _input ) public pure returns ( uint , string[] memory ) {

//         bytes memory inputBytes = bytes( _input ) ;

//         // bytes <> string 관계 좀 더 공부
//         // bytes byten 자릿수 

//         uint length = inputBytes.length ;

//         string[] memory rt_value = new string[]( length ) ;

//         for( uint i = 0 ; i < length ; i++ ) rt_value[ i ] = string( abi.encodePacked( inputBytes[ i ] ) ) ;

//         // return ( inputBytes[ 0 ] , length , rt_value ) ;
//         return ( length , rt_value ) ;

//     }

// }