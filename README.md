# airbnb-rentals

Rentals Using Smart Contracts
🔴 No More Middleman: Airbnb Liberation

Tired of hefty fees eating into profits?
Homeowners want more control over rentals.
Do we really need a costly intermediary?

🖥️ Why Blockchain? Liberate Rental Management.

Imagine homeowners taking charge of rentals.
Rental agreements as digital tokens.
Control and transparency increased.

🔗 Rental Revolution: Smart Contracts.

One contract per host, valid for a year.
Properties categorized into tiers.
Each day an NFT.

🟢 The Result: A Middleman-Free Future.

🔍 Eliminate the hefty service fees.
🏡 A new era of home-sharing begins.
🤝🏻 Cost savings for all, control regained.

### Step by step:
1. Owner deploys smart contract per year.
2. Owner creates properties (tiers).
3. Owner creates rental days (NFTs) for properties (using timestamps)
4. Owner lists rental days NFTs using own marketplace or third party marketplace with low fees.
5. Renters buy NFTs and gain access to property for timestamp range.

## Play around yourself!

### Mumbai testnet smart contracts:
- PropertyRentals: [0x9B185cA290941d5731AdeDCE31bB8b9BEaC6d127](https://mumbai.polygonscan.com/address/0x9B185cA290941d5731AdeDCE31bB8b9BEaC6d127)

### How to interact through PolygonScan
1. Obtain Mumbai MATIC. [FAUCET](https://faucet.polygon.technology/).
2. Create property. Use #2 createProperty. Inputs: id_ = sequential property number, name_ = anything. [WRITE CONTRACT](https://mumbai.polygonscan.com/address/0x9B185cA290941d5731AdeDCE31bB8b9BEaC6d127#writeContract).
3. Create rental days NFTs. Use #3 createRentalDay. Inputs: to = your wallet, tierId = id from step 2, startTime = start of rental, endTime = end of rental. [WRITE CONTRACT](https://mumbai.polygonscan.com/address/0x9B185cA290941d5731AdeDCE31bB8b9BEaC6d127#writeContract).
4. List on marketplace.