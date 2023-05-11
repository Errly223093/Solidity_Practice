// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.18;

contract map {
    mapping(uint => string) a;
    mapping(uint => uint) b;
    mapping(string => address) c;

    mapping(string => uint) height;

    function setstudent(string memory _name, uint _hgt) public {
	height[_name] = _hgt;
    }

    function getstudent(string memory _name) public view returns (uint) {
	return height[_name];
    }

}
