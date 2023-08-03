// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface ILinearPool {
  
  function linearPoolLength() external view returns (uint256);

  function linearBalanceOf(uint256 _poolId, address _account) external view returns (uint128);
  
  struct LinearPoolInfo {
        uint128 cap;
        uint128 totalStaked;
        uint128 minInvestment;
        uint128 maxInvestment;
        uint64 APR;
        uint128 lockDuration;
        uint128 delayDuration;
        uint128 startJoinTime;
        uint128 endJoinTime;
  }
  
  function linearPoolInfo(uint256 index) external view returns (LinearPoolInfo memory);
}