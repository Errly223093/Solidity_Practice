// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// ProxyAdmin

contract CounterV1 {
    uint public count;

    function increase() public {
        count += 1;
    }

    // 함수명이 같다면 proxy 컨트랙트의 함수를 호출. 값을 반환해준다.
    // 따라서 user 또는 admin 호출할 때의 인터페이스를 설정해준다.
    function admin() external pure returns(address) {
        return address(1);
    }

    function implementation() external pure returns(address) {
        return address(2);
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
    bytes32 private constant IMPLEMENTATION_SLOT = bytes32(
        uint(keccak256("implementation")) - 1
    );
    
    bytes32 private constant ADMIN_SLOT = bytes32(
        uint(keccak256("admin")) - 1
    );

    constructor() {
        _setAdmin(msg.sender);
    }

    function _delegate(address _implementation) private {
        // https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/proxy/Proxy.sol
        // _delegate assembly 를 사용한다. 복붙해줌.
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

    // 어드민이 함수 호출 시, proxy 컨트랙트 내부의 함수를 그대로 호출.
    // 유저가 호출 시, _fallback 함수 호출 => 로직 컨트랙트로 delegate call 하게 됨.
    modifier checkAdmin() {
        if(msg.sender == _getAdmin()){
            _;
        } else {
            _fallback();
        }
    }

    // modifier 로직 내부에서는 fallback 함수를 호출 할 수 없으므로 함수를 만들어줌.
    function _fallback() private {
        _delegate(_getImplementation());
    }

    fallback() external payable {
        _fallback();
    }

    receive() external payable {
        _fallback();
    }

    function changeAdmin(address _admin) external checkAdmin {
        _setAdmin(_admin);
    }

    // checkAdmin modifier 로 어드민임을 확인한다. require 문 삭제.
    function upgradeTo(address _implementation) external checkAdmin {
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

    function admin() external checkAdmin returns(address) {
        return _getAdmin();
    }

    function implementation() external checkAdmin returns(address)  {
        return _getImplementation();
    }
}

contract ProxyAdmin {
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == admin, "Admin only.");
        _;
    }

    /* 
    Proxy 컨트랙트로 부터 admin, implementation 함수를 call 한다.
    두 함수로 부터 반환 받는 값이 필요한데, 두 함수는 view 함수가 아니기 때문에 
    상태변수를 변경하지 않는 staticcall 로 호출한다.

    - 사용 법
    호출컨트랙트.staticcall(abi.encode(호출컨트랙트.함수,(인자. 없다면 빈칸으로)))
    abi.decode(반환 값, (decode 할 자료형))
    */
    function getProxyAdmin(address _Proxy) external view returns(address) {
        (bool success, bytes memory res) = _Proxy.staticcall(abi.encodeCall(Proxy.admin, ()));
        require(success, "Failed to call.");
        return abi.decode(res, (address));
    }

    function getProxyImplementation(address _Proxy) external view returns(address) {
        (bool success, bytes memory res) = _Proxy.staticcall(abi.encodeCall(Proxy.implementation, ()));
        require(success, "Failed to call.");
        return abi.decode(res, (address));
    }

    // Proxy 컨트랙트에는 payable 을 붙여준다. receive, fallback 함수가 있기 때문.
    function changeProxyAdmin(address payable _Proxy, address _admin) external onlyOwner {
        Proxy(_Proxy).changeAdmin(_admin);
    }

    function upgrade(address payable _Proxy, address _implementation) external onlyOwner {
        Proxy(_Proxy).upgradeTo(_implementation);
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