// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract mint721token is ERC721Enumerable {
    string public URI;

    constructor(string memory _uri) ERC721("BCS721","BCS"){
        URI = _uri;
    }

    function mintNFT(uint _tokenID) public {
        _mint(msg.sender, _tokenID);
    } 

    function tokenURI(uint _tokenID) public view override returns(string memory){
        return string(abi.encodePacked(URI, "/" , Strings.toString(_tokenID) , ".json"));
    } // uri 를 갖다 붙히는 작업
}

contract getFunctionID_getMethodId {
    function firstFourBytes(bytes20 _a) public pure returns(bytes4) {
        return bytes4(_a);
    }

    function getMethodID(string calldata _a) public pure returns(bytes4) {
        return bytes4(keccak256(bytes(_a))); // 앞뒤에 따옴표 이름(변수형,변수형)
    }
}

// method id 는 etherscan 에서 볼 수 있는데
// keccak256 으로 돌린 값의 앞 8자리(4bytes) 값이 method id 이다.