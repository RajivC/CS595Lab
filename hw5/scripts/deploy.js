// scripts/deploy.js
const { ethers } = require("hardhat");

async function main() {
  const depth = 8;
  // Compute the "empty tree" root by running your demo tool once with no deposits.
  // Or grab the initialRoot from your gen_toml output.
  const initialRoot = "0x…"; 

  // Deploy the two verifier contracts
  const DepositVerifier = await ethers.getContractFactory("DepositVerifier");
  const depositVerifier = await DepositVerifier.deploy();
  await depositVerifier.deployed();

  const WithdrawVerifier = await ethers.getContractFactory("WithdrawVerifier");
  const withdrawVerifier = await WithdrawVerifier.deploy();
  await withdrawVerifier.deployed();

  // Deploy the mixer
  const Whirlwind = await ethers.getContractFactory("Whirlwind");
  const whirlwind = await Whirlwind.deploy(
    depositVerifier.address,
    withdrawVerifier.address,
    depth,
    initialRoot
  );
  await whirlwind.deployed();

  console.log("DepositVerifier:", depositVerifier.address);
  console.log("WithdrawVerifier:", withdrawVerifier.address);
  console.log("Whirlwind:", whirlwind.address);
}

main().catch(console.error);