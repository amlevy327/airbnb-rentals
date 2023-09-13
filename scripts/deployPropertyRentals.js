const hre = require('hardhat');

async function main() {

  const PropertyRentals = await hre.ethers.getContractFactory(
    'PropertyRentals',
  );

  const name = "PropertyRentals"
  const symbol = "PR"

  const propertyRentals = await PropertyRentals.deploy(
    name,
    symbol
  );

  await propertyRentals.waitForDeployment();

  console.log(`propertyRentals deployed to ${await propertyRentals.getAddress()}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});