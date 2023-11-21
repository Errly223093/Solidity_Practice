// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract DataConsumerV3 {
    AggregatorV3Interface BTCUSD;
    AggregatorV3Interface JPYUSD;

    /**
     * Network: Sepolia
     * Aggregator: BTC/USD
     * Address: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
     * Aggregator: JPY/USD
     * Address: 0x8A6af2B75F23831ADc973ce6288e5329F63D86c6
     */
    constructor() {
        BTCUSD = AggregatorV3Interface(0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43);
        JPYUSD = AggregatorV3Interface(0x8A6af2B75F23831ADc973ce6288e5329F63D86c6);
    }

    function getBTCUSD() public view returns (int) {
        (,int256 answer,,,) = BTCUSD.latestRoundData();
        return answer;
    }

    function getJPYUSD() public view returns (int) {
        (,int256 answer,,,) = JPYUSD.latestRoundData();
        return answer;
    }

    function getBTCJPY() public view returns (int) {
        return (getBTCUSD()/getJPYUSD());
    }
}