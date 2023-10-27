// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract CounterV1 {
    uint public count;

    function increase() public {
        count += 1;
    }
}

contract CounterV2 {
    uint public count;

    function increase() public {
        count += 1;
    }

    function decrease() public {
        count -= 1;
    }
}

contract Proxy {
    bytes32 public constant IMPLEMENTATION_SLOT = bytes32(
        uint(keccak256("implementation")) - 1
    );
    
    bytes32 public constant ADMIN_SLOT = bytes32(
        uint(keccak256("admin")) - 1
    );

    constructor() {
        _setAdmin(msg.sender);
    }

    function _delegate(address _implementation) private {
        // https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/proxy/Proxy.sol
        // _delegate assembly 사용한다. 복붙해줌.
        assembly {
            // Copy msg.data. We take full control of memory in this inline assembly
            // block because it will not return to Solidity code. We overwrite the
            // Solidity scratch pad at memory position 0.
            calldatacopy(0, 0, calldatasize())

            // Call the implementation.
            // out and outsize are 0 because we don't know the size yet.
            let result := delegatecall(gas(), _implementation, 0, calldatasize(), 0, 0)

            // Copy the returned data.
            returndatacopy(0, 0, returndatasize())

            switch result
            // delegatecall returns 0 on error.
            case 0 {
                revert(0, returndatasize())
            }
            default {
                return(0, returndatasize())
            }
        }
    }

    fallback() external payable {
        _delegate(_getImplementation());
    }

    receive() external payable {
        _delegate(_getImplementation());
    }

    function upgradeTo(address _implementation) external {
        require(msg.sender == _getAdmin(), "Admin only.");
        _setImplementation(_implementation);
    }

    function _getAdmin() private view returns(address) {
        return StorageSlot.getAddressSlot(ADMIN_SLOT).value;
    }

    function _setAdmin(address _admin) private {
        require(_admin != address(0), "Admin address zero.");
        StorageSlot.getAddressSlot(ADMIN_SLOT).value = _admin;
    }

    function _getImplementation() private view returns(address) {
        return StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value;
    }

    function _setImplementation(address _implementation) private {
        require(_implementation.code.length > 0, "Not a contract.");
        StorageSlot.getAddressSlot(IMPLEMENTATION_SLOT).value = _implementation;
    }

    function admin() external view returns(address) {
        return _getAdmin();
    }

    function implementation() external view returns(address) {
        return _getImplementation();
    }
}

library StorageSlot {
    // struct 로 감싸주어야 아래 함수에서 인식함
    struct AddressSlot {
        address value;
    }

    // 포인터. 슬롯의 위치 값을 반환
    function getAddressSlot(bytes32 slot) internal pure returns(AddressSlot storage pointer){
        assembly{
            pointer.slot := slot
        }
    }
}

contract TestSlot {
    bytes32 public constant SLOT = keccak256("TEST_SLOT");

    function getSlot() external view returns(address) {
        // assembly 로 불러온 값이므로 .value 를 붙여주어야 함.
        return StorageSlot.getAddressSlot(SLOT).value;
    }

    function writeSlot(address _addr) external {
        StorageSlot.getAddressSlot(SLOT).value = _addr;
    }
}