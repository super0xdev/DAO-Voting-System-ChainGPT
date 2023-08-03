async function main() {
    const compoundAddr="0x765a6ee976137801F2661c3644E1fde369A8ED18";      //compoundStakingContract(IDecubateMasterContract) address
    const compounderAddr="0x5b1e724B79087DAe13517612A1E6575e9d340cFB";    //compounderContract(IDCBVault) address
    const linearStakingAddr="0x62A402DEf6Ca37E9CA7a544bE34954748088CCEE"; //linearStakingContract(ILinearPool) address
    const voteCont = await ethers.getContractFactory("VoteContract"); //Replace with name of your smart contract
    const vote = await voteCont.deploy(compoundAddr, compounderAddr, linearStakingAddr, 10000);
  
    console.log("vote address:", vote.address); //In frontend, we can load VoteContract using this address, and then get voting power using getVotingPower(user_address) function
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });

    //0x539f5349d2C556781BeF9e1c5ce5f463Fa056acf