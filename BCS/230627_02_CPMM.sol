// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol'; 

contract Token_A is ERC20("A_token", "A") {
    constructor(uint a) {
        _mint(msg.sender, a);
        // _mint(address(this), a);
    }

    function decimals() public pure override returns(uint8) {
        return 0;
    }
}

contract Token_B is ERC20("B_token", "B") {
    constructor(uint a) {
        _mint(msg.sender, a);
        // _mint(address(this), a);
    }

    function decimals() public pure override returns(uint8) {
        return 0;
    }
}


contract CPMM is ERC20("ABLP_Token", "ABLP"){
    // 토큰 설정
    ERC20 public token_a;
    ERC20 public token_b;

    address owner;

    constructor(address _a, address _b) {
        owner = msg.sender;
        token_a = ERC20(_a);
        token_b = ERC20(_b);
    }

    function burn(uint _amount) public {
        _burn(msg.sender, _amount);
    }

    // x*y=k;
    // uint public k;

    modifier isitAorB(address _token) {
        require(_token == address(token_a) || _token == address(token_b));
        _;
    }

    function balanceOfAB() public view returns(uint, uint) {
        return (token_a.balanceOf(address(this)), token_b.balanceOf(address(this)));
    }

    //유동성 공급 및 제거
    // 초기 유동성 공급
    function initialSupply() public {
        require(owner == msg.sender);
        token_a.transferFrom(tx.origin, address(this), 100);
        token_b.transferFrom(tx.origin, address(this), 300);

        _mint(msg.sender, 50);
    }

    // 공급
    function provideLiquidity(address _token, uint _a) public isitAorB(_token) {
        (uint bal_a, uint bal_b) = balanceOfAB();

        uint mint_lp;

        if(_token == address(token_a)) {
            uint _b = _a * bal_b / bal_a;

            token_a.transferFrom(tx.origin, address(this), _a);
            token_b.transferFrom(tx.origin, address(this), _b);

            mint_lp = _a * totalSupply() / bal_a;
        } else {
            uint _b = _a * bal_a / bal_b;

            token_a.transferFrom(tx.origin, address(this), _b);
            token_b.transferFrom(tx.origin, address(this), _a);

            mint_lp = _a * totalSupply() / bal_b;
        }

        // lp 토큰 지급
        _mint(msg.sender, mint_lp);
        // k = (bal_a + _a) * (bal_b + _b) ;
    }

    // 제거
    function withdrawLiquidity(uint _a) public {
        require(balanceOf(msg.sender) >= _a, "not enough");
        (uint bal_a, uint bal_b) = balanceOfAB();
        // lp 토큰 수령 후 확인

        uint a_out = _a * bal_a / totalSupply();
        uint b_out = _a * bal_b / totalSupply();

        burn(_a); // 소각

        token_a.transfer(msg.sender, a_out);
        token_b.transfer(msg.sender, b_out);
        // k =  (bal_a - _a) * (bal_b - _b);
    }

    // 거래
    function swapToken(address _token, uint _amount) public isitAorB(_token) {
        (uint bal_a, uint bal_b) = balanceOfAB();
        uint k = bal_a * bal_b;

        if(_token == address(token_a)) {
            uint out = bal_b - k / (bal_a + _amount);
            token_a.transferFrom(tx.origin, address(this), _amount);
            token_b.transfer(msg.sender, out);
        } else {
            uint out = bal_a - k / (bal_b + _amount);
            token_b.transferFrom(tx.origin, address(this), _amount);
            token_a.transfer(msg.sender, out);
        }
    }
}