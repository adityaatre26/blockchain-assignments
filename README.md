# Blockchain Lab Assignments

## Student Details
- Student Name: Aditya Atre
- Roll Number: 123B1B003
- Course Name: Blockchain Lab

## Overview
This repository contains five blockchain lab assignments covering the full stack of decentralized application development.

1. **Assignment 1: Smart Contract Development**
   - Built a meaningful Solidity smart contract with multiple functions, events, and state updates.
2. **Assignment 2: Polygon Testnet Deployment**
   - Prepared deployment of the Assignment 1 contract to Polygon Mumbai using Hardhat and environment variables.
3. **Assignment 3: Web Interface + MetaMask**
   - Created a browser-based frontend that connects to MetaMask and performs read/write smart contract interactions.
4. **Assignment 4: IPFS Integration**
   - Added a script to upload and retrieve content from IPFS and display CID plus gateway URL.
5. **Assignment 5: DAO Smart Contract**
   - Implemented a basic DAO workflow: create proposal, vote yes/no, and execute based on threshold.

## Tech Stack
- Solidity
- Hardhat
- MetaMask
- ethers.js
- IPFS

## How To Run Each Assignment

### Assignment 1 (Local Contract Development)
1. Move into your Hardhat workspace.
2. Copy `assignment-1/contract.sol` into your `contracts/` directory.
3. Compile:
   ```bash
   npx hardhat compile
   ```
4. Deploy locally (example):
   ```bash
   npx hardhat node
   npx hardhat run scripts/deploy.js --network localhost
   ```

### Assignment 2 (Polygon Mumbai Deployment)
1. Move into your Hardhat workspace.
2. Copy `assignment-2/contract.sol` into `contracts/` and `assignment-2/deploy.js` into `scripts/`.
3. Install dependencies:
   ```bash
   npm install dotenv hardhat @nomicfoundation/hardhat-toolbox
   ```
4. Set required environment variables in `.env` (do not commit `.env`):
   - `PRIVATE_KEY`
   - `ALCHEMY_API_KEY`
5. Deploy:
   ```bash
   npx hardhat run scripts/deploy.js --network mumbai
   ```

### Assignment 3 (Frontend + MetaMask)
1. Open `assignment-3/index.html` in a local static server.
2. Update contract address and ABI in `assignment-3/app.js`.
3. Connect MetaMask to the correct network.
4. Click **Connect Wallet**, then test read/write buttons.

### Assignment 4 (IPFS Script)
1. Install package:
   ```bash
   npm install web3.storage
   ```
2. Set environment variable in `.env`:
   - `WEB3_STORAGE_TOKEN`
3. Run script:
   ```bash
   node assignment-4/ipfs.js
   ```

### Assignment 5 (DAO Contract)
1. Copy `assignment-5/DAO.sol` into your Hardhat `contracts/` folder.
2. Compile:
   ```bash
   npx hardhat compile
   ```
3. Deploy using your preferred Hardhat deploy script and network.
4. Interact through a script, console, or frontend to create proposals, vote, and execute.
