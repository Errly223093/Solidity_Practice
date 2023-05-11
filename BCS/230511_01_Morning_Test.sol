// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Mapping {
    mapping(uint=>uint) a;
    mapping(string=>uint) b;
    
    struct wallet {
        string name;
        uint number;
        address wallet;
    }

    mapping(string =>address) c;

    wallet[] wallets;

    function setWallets(string memory _name, uint _number, address _wallet) public {
        wallets.push(wallet(_name,_number,_wallet));
    } 

    function getWallets(uint _n) public view returns(wallet memory) {
        return wallets[_n-1];
    }

    function getWallet(uint _n) public view returns(address) {
        return wallets[_n-1].wallet;
    }

    function getAllWallet() public view returns(wallet[] memory){
        return wallets;
    }
}

contract Mapping1{
    uint[10] a;
    uint[] b;

    function setA(uint _n, uint _nn) public {
        a[_n-1] = _nn;
    }

    function setB(uint _n) public {
        b.push(_n);
    }

    function setB2(uint _index, uint _n) public {
        b[_index-1] = _n;
    }
    
    function addA() public view returns(uint) {
        uint add;
        for(uint i=0; i<a.length; i++){
            add = add+a[i];
        }
        return add;
    }
}

