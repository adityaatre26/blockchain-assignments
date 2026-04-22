# Assignment 3 - Web Interface + MetaMask

## Objective
Build a frontend dApp that connects to MetaMask and interacts with the smart contract from Assignment 1.

## What This Frontend Does
- Connects user wallet through MetaMask.
- Displays the connected wallet address.
- Calls one **write function**: `createTask`.
- Calls one **read function**: `getTaskCount`.
- Uses `ethers.js` through a CDN in browser.

## How The Frontend Connects To Blockchain
1. Browser detects `window.ethereum` injected by MetaMask.
2. Frontend creates an `ethers.BrowserProvider(window.ethereum)` instance.
3. User approves account access via `eth_requestAccounts`.
4. Frontend gets signer from provider.
5. Frontend creates contract instance with:
   - Contract address
   - Contract ABI
   - Signer
6. Read/write function calls are made through this contract instance.

## How MetaMask Is Used
- MetaMask provides wallet identity and signs transactions.
- For write operations (`createTask`), MetaMask opens a confirmation popup.
- User approves transaction; MetaMask broadcasts it to the selected network.
- For read operations (`getTaskCount`), no transaction fee is required.

## Setup Steps
1. Replace `CONTRACT_ADDRESS` in `app.js` with your deployed contract address.
2. Confirm ABI in `app.js` matches deployed contract.
3. Serve files with a local web server, for example:
   ```bash
   npx serve .
   ```
4. Open `index.html` in browser.
5. Connect MetaMask and interact with buttons.

## Screenshot Placeholders
- [Screenshot: wallet connected]
- [Screenshot: createTask transaction prompt]
- [Screenshot: createTask success status]
- [Screenshot: getTaskCount output]
