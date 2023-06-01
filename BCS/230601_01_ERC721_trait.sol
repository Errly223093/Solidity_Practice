// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract mint721token is ERC721Enumerable {
    string public URI;

    constructor(string memory _uri) ERC721("color","clr"){
        URI = _uri;
    }

    function mintNFT(uint _tokenID) public {
        _mint(msg.sender, _tokenID);
    } 

    function batchmint(uint _num) public {
        for(uint i=1 ; i <= _num ; i++){
            _mint(msg.sender, i);
        }
    }

    function burnNFT(uint tokenId) public {
        _burn(tokenId);
    }

    function BatchBurn(uint _num) public {
        for(uint i=1 ; i <= _num ; i++){
            _burn(i);
        }
    }

    function tokenURI(uint _tokenID) public view override returns(string memory){
        return string(abi.encodePacked(URI, "/" , Strings.toString(_tokenID) , ".json"));
    } // uri 를 갖다 붙히는 작업
}