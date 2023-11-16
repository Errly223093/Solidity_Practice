// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/PaulRBerg/prb-math/blob/v1.0.3/contracts/PRBMathSD59x18.sol";

contract test{
    using PRBMathSD59x18 for *;

    function mul(int x, int y) external pure returns(int){
        return x.mul(y);
    }
    
}
