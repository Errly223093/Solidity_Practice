// // SPDX-License-Identifier: MIT
// pragma solidity 0.8.18;

// // 로또 프로그램을 만드려고 합니다. 숫자와 문자는 각각 4개 2개를 뽑습니다. 
// // 6개가 맞으면 1이더, 
// // 5개의 숫자가 순서와 함께 맞으면 0.75이더, 
// // 4개가 맞으면 0.25이더, 
// // 3개가 맞으면 0.1이더 
// // 2개 이하는 상금이 없습니다.

// // 참가 금액은 0.05 이더.

// // 기준 숫자 : 1,2,3,4,A,B
// // -----------------------------------------------------------------
// // 기준 숫자 설정 기능 : 5개의 사람이 임의적으로 4개의 숫자와 2개의 문자를 넣음. 
// // 5명이 넣은 숫자들의 중앙값과 알파벳 순으로 따졌을 때 가장 가운데 문자로 설정
// // 예) 숫자들의 중앙값 : 1,3,6,8,9 -> 6 // 2,3,4,8,9 -> 4
// // 예) 문자들의 중앙값 : a,b,e,h,l -> e // a,h,i,q,z -> i

// import "@openzeppelin/contracts/utils/Strings.sol";

// contract q8{

//     function start(uint _a, uint _b, uint _c, uint _d, string memory _e, string memory _f) public payable returns(string memory) {
        
//         require(msg.sender.balance >= 5 * 10 * 16, "Check your balance first.");
//         // payable(address(this)).transfer(0.05 ether);

//         string[] memory key;

//         key[0] = Strings.toString(_a);
//         key[1] = Strings.toString(_b);
//         key[2] = Strings.toString(_c);
//         key[3] = Strings.toString(_d);
//         key[4] = _e;
//         key[5] = _f;

//         string[] memory lottokey;

//         lottokey[0] = Strings.toString(1);
//         lottokey[1] = Strings.toString(2);
//         lottokey[2] = Strings.toString(3);
//         lottokey[3] = Strings.toString(4);
//         lottokey[4] = "A";
//         lottokey[5] = "B";

//         uint score;

//         for(uint i; i < key.length; i++){
//             if(keccak256(abi.encodePacked(key[i])) == keccak256(abi.encodePacked(lottokey[i]))){
//                 score += 1;
//             }

//         }

//     }
// }

// // SPDX-License-Identifier: GPL-3.0

// pragma solidity ^0.8.0;

// /*
// 로또 프로그램을 만드려고 합니다. 숫자와 문자는 각각 4개 2개를 뽑습니다.
// 6개가 맞으면 1이더, 5개의 숫자가 순서와 함께 맞으면 0.75이더, 4개가 맞으면 0.25이더, 3개가 맞으면 0.1이더 2개 이하는 상금이 없습니다. 

// 참가 금액은 0.05이더이다.

// 기준 숫자 : 1,2,3,4,A,B
// -----------------------------------------------------------------
// 기준 숫자 설정 기능 : 5개의 사람이 임의적으로 4개의 숫자와 2개의 문자를 넣음. 5명이 넣은 숫자들의 중앙값과 알파벳 순으로 따졌을 때 가장 가운데 문자로 설정
// 예) 숫자들의 중앙값 : 1,3,6,8,9 -> 6 // 2,3,4,8,9 -> 4
// 예) 문자들의 중앙값 : a,b,e,h,l -> e // a,h,i,q,z -> i
// */

// contract test{

//     string ans ;
//     uint public reward = 0 ; // 값 체크용

//     function set_string_basic( string memory _input ) public{

//         ans = _input ;

//     }

//     function f_string( string memory _input ) public payable {
        
//         // 스트링 분할

//         // bytes  bytes1 
//         // abi.encodedPacked( ) 

//         bytes memory cmp1 = bytes( _input ) ;
//         bytes memory cmp2 = bytes( ans ) ;
//         uint length = cmp1.length ;

//         require( length == 6 , "only 6 str" ) ;
//         require( msg.value == 0.05 ether , "participation fee is 0.05 eth" ) ;
//         // require( msg.value == 50 finney , "participation fee is 0.05 eth" ) ;
//         // finney로는 못적나  50 finney 에러나던데

//         uint cnt = 0 ;
//         //cnt = 0 ;

//         for( uint i = 0 ; i < length ; i ++ ){
//             if( cmp1[ i ] == cmp2[ i ] ) cnt ++ ;
//         } 

//         // 6개가 맞으면 1이더, 5개의 숫자가 순서와 함께 맞으면 0.75이더, 4개가 맞으면 0.25이더, 3개가 맞으면 0.1이더 2개 이하는 상금이 없습니다.

//         reward = 0 ; // 초기화

//         if( cnt == 6 ) reward = 1 ether ;
//         else if( cnt == 5 ) reward = 0.75 ether ;
//         else if( cnt == 4 ) reward = 0.25 ether ;
//         else if( cnt == 3 ) reward = 0.1 ether ;

//     }

//     // 기준 숫자 설정 기능 : 5개의 사람이 임의적으로 4개의 숫자와 2개의 문자를 넣음. 5명이 넣은 숫자들의 중앙값과 알파벳 순으로 따졌을 때 가장 가운데 문자로 설정
//     // 예) 숫자들의 중앙값 : 1,3,6,8,9 -> 6 // 2,3,4,8,9 -> 4
//     // 예) 문자들의 중앙값 : a,b,e,h,l -> e // a,h,i,q,z -> i

//     bytes1[ 6 ][ 5 ] public setting_num ;
//     // setting_num[ i ][ j ] : i 번째 자리  , j 입력
//     uint public setting_size = 0 ;

//     function string_sort() internal {

//         for( uint k = 0 ; k < 6 ; k ++ ) {

//         for( uint i = 0 ; i < 5 ; i ++ ) {

//             for( uint j = i + 1 ; j < 5 ; j ++ ){

//                 if( setting_num[ k ][ i ] > setting_num[ k ][ j ] ) ( setting_num[ k ][ i ] , setting_num[ k ][ j ] ) = ( setting_num[ k ][ j ] , setting_num[ k ][ i ] ) ;

//             }

//         }

//         }

//     }

//     function set_string_adv( string memory _input ) public {
//     bytes memory temp = bytes( _input ) ;
//     require( temp.length == 6, "only 6 str" ) ;

//     for ( uint i = 0 ; i < 6 ; i ++ ) setting_num[ i ][ setting_size ] = bytes1( temp[ i ] ) ;

//     if ( setting_size == 5 ) {

//         string_sort() ;

//         string[] memory rt_value = new string[]( 6 ) ;

//         for( uint i = 0 ; i < 6 ; i++ ) rt_value[ i ] = string( abi.encodePacked( setting_num[ i ][ 2 ] ) ) ;

//         ans = rt_value[ 0 ] ;

//         for( uint i = 1 ; i < 6 ; i ++ ) ans = string( abi.encodePacked( ans , rt_value[ i ] ) ) ;

//         setting_size = 0;

//     }

// }


// }