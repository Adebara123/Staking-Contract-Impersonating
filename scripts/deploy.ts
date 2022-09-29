import { ethers } from "hardhat";

const helpers = require("@nomicfoundation/hardhat-network-helpers");

async function main() {

  const Token = await ethers.getContractFactory("Erc20Token");
  const token = await Token.deploy();

  await token.deployed();

  // contract address
  const tokenAddress = await token.address;
  console.log("this is ur token contract addres", tokenAddress);
  
  const Stake = await ethers.getContractFactory("staking");
  const stake = await Stake.deploy(tokenAddress);
  await stake.deployed();
  
    // stake address
  const stakeAddress = await  stake.address;
  console.log("this is ur stake contract addres", stakeAddress)

  // impoersonating the person 

  const address = "0x758c32B770d656248BA3cC222951cF1aC1DdDAaA";
  await helpers.impersonateAccount(address);
  const impersonatedSigner = await ethers.getSigner(address);
  console.log(impersonatedSigner)


 const transferToStake =await token.transferOut(stakeAddress, "1000000000000000000000");
 console.log(transferToStake)

 const transferToAddress = await token.transferOut(stakeAddress, "10000000000000000000");
 console.log(transferToAddress);

 // Stake 

 const stakeContract = await ethers.getContractAt("IStake", stakeAddress, impersonatedSigner);
 const personStaking = await stakeContract.stake("10000000000000000000");

 console.log(personStaking);


}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
