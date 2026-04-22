# Assignment 2 - Polygon Deployment

## Objective
Deploy the `TaskTracker` contract to the Polygon Mumbai testnet using Hardhat.

## Files
- `contract.sol`: Same smart contract from Assignment 1.
- `deploy.js`: Hardhat deployment script for Mumbai testnet.

## Required Environment Variables
Create a `.env` file in your Hardhat project root with:

```env
PRIVATE_KEY=<your_wallet_private_key>
ALCHEMY_API_KEY=<your_alchemy_api_key>
```

These values are required for account signing and RPC access.

## Mumbai Network Details
- Network Name: Polygon Mumbai Testnet
- RPC URL: `https://polygon-mumbai.g.alchemy.com/v2/${ALCHEMY_API_KEY}`
- Chain ID: `80001`
- Currency Symbol: `MATIC`
- Block Explorer: `https://mumbai.polygonscan.com`

## Hardhat Configuration Example
Add this in your `hardhat.config.js`:

```js
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: "0.8.20",
  networks: {
    mumbai: {
      url: `https://polygon-mumbai.g.alchemy.com/v2/${process.env.ALCHEMY_API_KEY}`,
      accounts: [process.env.PRIVATE_KEY]
    }
  }
};
```

## Deployment Steps
1. Install dependencies:
   ```bash
   npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox
   npm install dotenv
   ```
2. Copy `contract.sol` into `contracts/TaskTracker.sol`.
3. Copy `deploy.js` into `scripts/deploy.js`.
4. Compile contract:
   ```bash
   npx hardhat compile
   ```
5. Deploy to Mumbai:
   ```bash
   npx hardhat run scripts/deploy.js --network mumbai
   ```

## Deployment Output Placeholder
CONTRACT_ADDRESS: `<paste here>`

## Screenshot Placeholders
- [Screenshot: hardhat config]
- [Screenshot: compilation success]
- [Screenshot: deployment transaction]
- [Screenshot: deployed contract on polygonscan]
