// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "../interfaces/IDecubateMasterChef.sol";
import "../interfaces/IDCBVault.sol";
import "../interfaces/ILinearPool.sol";

contract VoteContract is Ownable {
    IDecubateMasterChef public compoundStakingContract;
    IDCBVault public compounderContract;
    ILinearPool public linearStakingContract;
    address CGPTAddress;
    uint256 voteRate;

    using SafeMath for uint256;

    constructor(
        address _compoundStakingContract,
        address _compounderContract,
        address _linearStakingContract,
        uint256 _voteRate
    ) 
    {
        compoundStakingContract = IDecubateMasterChef(_compoundStakingContract);
        compounderContract = IDCBVault(_compounderContract);
        linearStakingContract = ILinearPool(_linearStakingContract);
        voteRate = _voteRate;
        CGPTAddress = 0x9840652DC04fb9db2C43853633f0F62BE6f00f98;
    ']
    function setVoteRate(uint256 newRate) external onlyOwner {
        voteRate = newRate;
    }

    function getVotingPower(address addr) public view returns (uint256 amount) {
        uint256 tempAmt;

        //V1 Staking
        uint256 len_1 = compoundStakingContract.poolLength();

        for (uint256 i = 0; i < len_1; i++) {
            (, uint256 localPeriodDays, , , , , address token) = compoundStakingContract.poolInfo(i);

            if (token == CGPTAddress) {
                (, , tempAmt, ) = compounderContract.users(i, addr);
                uint256 pw; //Power according to the localPeriodDayss
                if(localPeriodDays==15) pw=10;
                else if(localPeriodDays==45) pw=10;
                else if(localPeriodDays==180) pw=15;
                else if(localPeriodDays==365) pw=20;
                amount = amount.add(tempAmt.mul(pw));
            }
        }

        //V2 Staking
        uint256 len_2 = linearStakingContract.linearPoolLength();
        
        for (uint256 i = 0; i< len_2; i++) {
            tempAmt = linearStakingContract.linearBalanceOf(i, addr);
            uint256 lockDuration = linearStakingContract.linearPoolInfo(i).lockDuration;
            uint256 pw;
            if(lockDuration==45) pw=10;
            else if(lockDuration==90) pw=13;
            else if(lockDuration==180) pw=15;
            else if(lockDuration==365) pw=20;
            amount = amount.add(tempAmt.mul(pw));
        }

        return
            amount.mul(voteRate).div(
                10 ** 5
            );
    }
}
