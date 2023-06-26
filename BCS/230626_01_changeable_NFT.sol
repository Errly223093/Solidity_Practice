// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract mint721token is ERC721Enumerable {
    string public Before_URI;
    string public After_URI;

    mapping(uint => bool) public status;

    constructor(string memory b_uri, string memory a_uri) ERC721("changeable","CH"){
        Before_URI = b_uri;
        After_URI = a_uri;
    }

    function setTokenStatus(uint _number, bool _status) public {
        status[_number] = _status;
    }

    function mintNFT(uint _tokenID) public {
        _mint(msg.sender, _tokenID);
    } 

    function tokenURI(uint _ID) public view override returns(string memory){
        if(status[_ID] == false){
            return string(abi.encodePacked(Before_URI,'/b',Strings.toString(_ID), '.json'));
        } else {
            return string(abi.encodePacked(After_URI,'/a',Strings.toString(_ID), '.json'));
        }
    }
}