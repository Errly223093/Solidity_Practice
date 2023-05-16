// // SPDX-License-Identifier: GPL-3.0

// pragma solidity ^0.8.18;

// contract Dad {
//     function add(uint a, uint b) public pure returns(uint) {
//         return a+b;
//     }
// }

// contract Mom {
//     function sub(uint a, uint b) public pure returns(uint) {
//         return a-b;
//     }
// }

// contract Child is Dad {
//     function mul(uint a, uint b) public pure returns(uint) {
//         return a*b;
//     }

//     function mul2(uint a, uint b) virtual public pure returns(uint) {
//         return a*b*2;
//     }

//     function addDoubleTime(uint a, uint b) public pure returns(uint) {
//         return Dad.add(a,b)*2;
//     }
// }

// contract Child2 is Dad, Mom {
//     function mul(uint a, uint b) public pure returns(uint) {
//         return a*b;
//     }
// }

// contract GrandChild is Child {
//     function div(uint a, uint b) public pure returns(uint) {
//         return a/b;
//     }
// }

// contract GrandChild2 is Child {
//     function mul2(uint a, uint b) override public pure returns(uint) {
//         return a*a*b;
//     }
// }


// contract DAD {
//     uint a;

//     uint public wallet=100; // 공개한 지갑 잔액
//     uint internal crypto=1000; // 메모장에 private key가 있는 크립토 잔액
//     uint private emergency=10000; // 진짜 비상금

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

//     function getAddress() public view returns(address) {
//         return address(this);
//     }
// }

// contract MOM {
//     DAD husband = new DAD();
//     function who() virtual public pure returns(string memory) {
//         return "mom from MOM";
//     }

//     function getHusbandChar() public view returns(string memory) {
//         return husband.character();
//     }

//     function getWallet() public view returns(uint) {
//         return husband.wallet();
//     }

//     function husbandAddress() public view returns(address) {
//         return address(husband);
//     }

//     /*
//     Visibility에서 차단
//     function getCrypto() public view returns(uint) {
//         return husband.crypto();
//     }

//     function getEmergency() public view returns(uint) {
//         return husband.emergency();
//     }
//     */
// }

// contract CHILD is DAD {
//     function who() override public pure returns(string memory) {
//         return super.who();
//         // return "child from CHILD";
//     }

//     function fathersName() public pure returns(string memory) {
//         return super.name();
//     }

//     function fathersWallet() public view returns(uint) {
//         return DAD.wallet;
//     }

//     function fathersCrypto() public view returns(uint) {
//         return DAD.crypto;
//     }

//     function fathersAddress() public view returns(address) {
//         return DAD.getAddress();
//     }

//     function fathersAddress2() public view returns(address) {
//         return super.getAddress();
//     }

//     DAD daddy = new DAD();
//     DAD daddy2 = new DAD();

//     /*function fathersName2() public pure returns(string memory) {
//         return daddy.name();
//     }*/

//     function fathersWallet2() public view returns(uint) {
//         return daddy.wallet();
//     }

//     /*function fathersCrypto2() public view returns(uint) {
//         return daddy.crypto();
//     }*/

//     function getDaddyAddress() public view returns(address) {
//         return address(daddy);
//     }

//     function getDaddy2Address() public view returns(address) {
//         return address(daddy2);
//     }

//     /*
//     Visibility - private 막힘
//     function fathersEmergency() public view returns(uint) {
//         return DAD.emergency;
//     }
//     */

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

    /*
    오류 발생 상속받은 아이는 external 접근 불가능
    function fathersChar() public pure returns(string memory) {
        return super.character();
    }
    */

    /*
    오류 발생 password는 private 함수
    function password_Dad() public pure returns(uint) {
        return super.password();
    }
    */
//}

contract DAD {
    uint a;

    uint public wallet=100; // 공개한 지갑 잔액
    uint internal crypto=1000; // 메모장에 private key가 있는 크립토 잔액
    uint private emergency=10000; // 진짜 비상금

    function password() private pure returns(uint) {
        return 1234;
    }

    function changeWallet(uint _n) public {
        wallet = _n;
    }

}

contract MOM {
    DAD husband = new DAD();
    DAD realHusband;

    constructor(address _a){
        realHusband = DAD(_a);
    }
        
    function getwallet() public view returns(uint) {
        return husband.wallet();
    }

    function getRealwallet() public view returns(uint) {
        return realHusband.wallet();
    }
}

contract CHILD is DAD {

    DAD daddy = new DAD();
    DAD daddy2 = new DAD();

}

// 0xDA0bab807633f07f013f94DD0E6A4F96F8742B53