const { ethers } = require("hardhat");
require("dotenv").config({ path: ".env" });
const { BOLETOS_NFT_CONTRACT_ADDRESS } = require("../constants");
const { DEPLOYED_ERC20_CONTRACT_ADDRESS } = require("../constants");


async function main() {
  // Address of the NFT contract that you deployed in the previous module
  const BoletosNFTContract = BOLETOS_NFT_CONTRACT_ADDRESS;
  
  const boleTokenContract = await ethers.getContractFactory(
    "Boletoken"
  );

  // deploy the contract
  const deployedboleTokenContract = await boleTokenContract.deploy(
    BoletosNFTContract
  );

  // print the address of the deployed contract
  console.log(
    "Boletoken Contract Address:",
    deployedboleTokenContract.address
  );

   // Deploy Collateral
   const boleTokenCollateralContract = await ethers.getContractFactory(
    "BoletosInterchain"
    );

// deploy the contract
  const deployedInterchainTokenContract = await boleTokenCollateralContract.deploy(
    DEPLOYED_ERC20_CONTRACT_ADDRESS);
}

console.log(
  "BoletokenInterchain Contract Address:",
  deployedInterchainTokenContract.address
);

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
