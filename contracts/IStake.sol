// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./staking.sol";

interface IStake {

    function stake(uint _amount) external;

    function withdraw () external;
}