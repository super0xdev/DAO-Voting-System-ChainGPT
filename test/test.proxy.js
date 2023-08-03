// test/Rematic.proxy.js
// Load dependencies
const { expect } = require('chai');

let Rematic;
let rematic;

// Start test block
describe('Rematic (proxy)', function () {
  beforeEach(async function () {
    vaultContract = await ethers.getContractFactory("DCBVault");
    chefContract = await ethers.getContractFactory("DecubateMasterChef");
    tiersContract = await ethers.getContractFactory("DecubateTiers");
    voteContract = await ethers.getContractFactory("VoteContract");

    chef=await chefContract.deploy();
    vault=await vaultContract.deploy(chef);
    // tiers=await tiersContract.deploy();
    // vote=await voteContract.deploy(tiers.address);
  });

  // Test case
  it('retrieve returns a value previously initialized', async function () {
    // Test if the returned value is the same one
    // Note that we need to use strings to compare the 256 bit integers
    expect((await rematic.symbol()).toString()).to.equal('RMTX');

    const [addr1, addr2] = await ethers.getSigners();

    await vault.deposit(0, 100);
  });
});