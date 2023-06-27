// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract mint721token is ERC721Enumerable {
    string public URI;

    ERC20 public token_a;

    constructor(string memory _uri) ERC721("nft","nft2s"){
        URI = _uri;
    }
    
    function setToken_A(address _a) public {
        token_a = ERC20(_a);
    }

    function mintNFT(uint _tokenID) public payable {
        require(msg.value == 0.001 ether);
        _mint(msg.sender, _tokenID);
    }

    function mintNFTWithERC20(uint _tokenID) public {
        token_a.transferFrom(tx.origin, address(this), 1000);
        _mint(msg.sender, _tokenID);
    }

    function tokenURI(uint _ID) public view override returns(string memory){
        return string(abi.encodePacked(URI,'/b',Strings.toString(_ID), '.json'));
    }
}

contract AToken is ERC20("LikeLion", "LION") {
    constructor(uint totalSupply) {
        _mint(msg.sender, totalSupply);
    }

    function MintToken(uint a) public {
        _mint(address(this), a);
    }

    function decimals() public pure override returns(uint8) {
        return 0;
    }

    receive() external payable{}
}