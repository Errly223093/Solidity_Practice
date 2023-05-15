// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract test {
/* 자동차를 운전하려고 합니다.
자동차의 상태에는 정지, 운전중, 시동 끔, 연료없음 총 4가지 상태가 있습니다.

정지는 속도가 0인 상태, 운전 중은 속도가 있는 상태이다. */
    struct car {
        bool sleep;
        bool speed;
        uint accel;
        uint broke;
        uint fuel;
    }

    receive() external payable{}

    address fuelowner = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2; // 사장님 지갑

    car cars;

// * 악셀 기능 - 속도를 1 올리는 기능, 악셀 기능을 이용할 때마다 연료가 2씩 줄어듬, 연료가 30이하면 더 이상 악셀을 이용할 수 없음, 70이상이면 악셀 기능은 더이상 못씀
    function accelator() public {
        require(cars.fuel >= 30 && cars.fuel <=70 && cars.sleep==false, "check fuel");
        cars.speed = true;
        cars.fuel = cars.fuel = cars.fuel - 2;
    }

// * 브레이크 기능 - 속도를 1 줄이는 기능, 속도가 0인 상태, 브레이크 기능을 이용할 때마다 연료가 1씩 줄어듬, 속도가 0이면 브레이크는 더이상 못씀
    function broke() public {
        require(cars.speed == true,"current speed 0 !");
        cars.speed = false;
        cars.fuel = cars.fuel - 1;
    }

// * 시동 끄기 기능 - 시동을 끄는 기능, 속도가 0이 아니면 시동은 꺼질 수 없음
    function sleep() public {
        require(cars.speed == false, "make speed 0 first.");
        cars.sleep = true;
    }

// * 시동 켜기 기능 - 시동을 켜는 기능, 시동을 키면 정지 상태로 설정됨
    function awake() public {
        require(cars.fuel >= 1, "No fuel !");
        cars.speed = true;
        cars.sleep = false;
    }

// * 주유 기능 - 주유하는 기능, 주유를 하면 1eth를 지불해야하고 연료는 100이 됨, 지불은 smart contract에게 함.
    function refuel() public payable {
        payable(this).transfer(1 ether);
        cars.fuel = 100;
    }

// ----------------------------------------------------------------------------------------
// * 주유소 사장님은 2번 지갑의 소유자임, 주유소 사장님이 withdraw하는 기능
    function withdraw() public {
        require(fuelowner == msg.sender,"this function for fuelowner only");
        payable(fuelowner).transfer(address(this).balance);
    }


    // * 지불을 미리 하고 주유시 차감하는 기능 *
mapping(address => bytes32) payfirstowner;

    function payfirst(uint _amount) public {
        if(payfirstowner[msg.sender]==0){
            payfirstowner[msg.sender] == 
        }
        
    }
}