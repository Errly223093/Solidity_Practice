// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract vis{
    function publicF() public pure returns(string memory) {
        return "public";
    }

        function privateF() private pure returns(string memory) {
        return "private";
    }

        function internalF() internal pure returns(string memory) {
        return "internal";
    }

        function externalF() external pure returns(string memory) {
        return "external";
    }

        function testPrivate() public pure returns(string memory){
            return privateF();
        }

        // function testexternal() public pure returns(string memory){
        //     return externalF();
        // }
}

contract DAD {
    function who() virtual public pure returns(string memory) {
        return "dad from DAD";
    }
}

contract MOM {
    function who() virtual public pure returns(string memory) {
        return "mom from MOM";
    }
}

contract CHILD is DAD {
    function who() override public pure returns(string memory) {
        return "child from CHILD";
    }
}

contract CHILD2 is DAD, MOM {
    function who() virtual override(DAD, MOM) public pure returns(string memory) {
        super.who;
    }
}

contract CHILD3 is DAD {

    uint public a;

    function who() override public pure returns(string memory) {
        return "child from CHILD";
    }

    function who(uint a) public pure returns(string memory, uint) {
        return ("dad from CHILD", a);
    }
}

// /* CHILD2는 who라는 function을 DAD, MOM으로부터 받아오지만
// 동시에 GRANDCHILD에게 상속도 해줌. 따라서 virtual 와 override 동시에 선언*/
// contract CHILD4 is DAD, MOM {
//     function who() virtual override(DAD, MOM) public pure returns(string memory) {
//         return "child from CHILD";
//     }
// }

// contract GRANDCHILD is CHILD2 {
//     function who() override public pure returns(string memory) {
//         return "grandChild";
//     }
// }

// contract DAD12 {
//     function who() virtual public pure returns(string memory) {
//         return "dad from DAD";
//     }

//     function name() internal pure returns(string memory) {
//         return "David";
//     }

//     function password() private pure returns(uint) {
//         return 1234;
//     }
// }

// contract DAD {
//     function who() virtual public pure returns(string memory) {
//         return "dad from DAD";
//     }

//     function name() internal pure returns(string memory) {
//         return "David";
//     }

//     function password() private pure returns(uint) {
//         return 1234;
//     }

//     function character() external pure returns(string memory) {
//         return "not good";
//     }
// }

// contract MOM {
//     DAD husband = new DAD();
//     function who() virtual public pure returns(string memory) {
//         return "mom from MOM";
//     }
// }

// contract CHILD is DAD {
//     function who() override public pure returns(string memory) {
//         return super.who();
//         // return "child from CHILD";
//     }

//     function fathersName() public pure returns(string memory) {
//         return super.name();
//     }

//     /*
//     오류 발생 상속받은 아이는 external 접근 불가능
//     function fathersChar() public pure returns(string memory) {
//         return super.character();
//     }
//     */

//     /*
//     오류 발생 password는 private 함수
//     function password_Dad() public pure returns(uint) {
//         return super.password();
//     }
//     */
// }

// contract CHILD2 is DAD, MOM {
//     function who() virtual override(DAD, MOM) public pure returns(string memory) {
//         return super.who();
//         // return "child from CHILD";
//     }
// }