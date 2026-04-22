// Contract address placeholder. Replace with your deployed contract address.
const CONTRACT_ADDRESS = "0xYOUR_CONTRACT_ADDRESS_HERE";

// ABI includes one write function and one read function used by this UI.
const CONTRACT_ABI = [
    {
        "inputs": [
            {
                "internalType": "string",
                "name": "description",
                "type": "string"
            }
        ],
        "name": "createTask",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "getTaskCount",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    }
];

// UI element references for status updates and user interaction.
const connectWalletBtn = document.getElementById("connectWalletBtn");
const walletStatus = document.getElementById("walletStatus");
const createTaskBtn = document.getElementById("createTaskBtn");
const getTaskCountBtn = document.getElementById("getTaskCountBtn");
const taskDescriptionInput = document.getElementById("taskDescription");
const taskCountStatus = document.getElementById("taskCountStatus");
const txStatus = document.getElementById("txStatus");

// Provider, signer, and contract instances are initialized after wallet connection.
let provider;
let signer;
let contract;

// Connects MetaMask, requests account access, and prepares ethers contract instance.
async function connectWallet() {
    try {
        if (!window.ethereum) {
            walletStatus.textContent = "MetaMask not found. Please install MetaMask.";
            return;
        }

        provider = new ethers.BrowserProvider(window.ethereum);
        await provider.send("eth_requestAccounts", []);
        signer = await provider.getSigner();
        const walletAddress = await signer.getAddress();

        contract = new ethers.Contract(CONTRACT_ADDRESS, CONTRACT_ABI, signer);

        walletStatus.textContent = `Connected wallet: ${walletAddress}`;
        txStatus.textContent = "Wallet connected. Ready to interact with contract.";
    } catch (error) {
        walletStatus.textContent = `Connection failed: ${error.message}`;
    }
}

// Calls createTask write function and waits for transaction confirmation.
async function createTask() {
    try {
        if (!contract) {
            txStatus.textContent = "Please connect wallet first.";
            return;
        }

        const description = taskDescriptionInput.value.trim();
        if (!description) {
            txStatus.textContent = "Task description cannot be empty.";
            return;
        }

        txStatus.textContent = "Submitting createTask transaction...";
        const tx = await contract.createTask(description);
        await tx.wait();

        txStatus.textContent = `Task created successfully. Tx hash: ${tx.hash}`;
        taskDescriptionInput.value = "";
    } catch (error) {
        txStatus.textContent = `createTask failed: ${error.message}`;
    }
}

// Calls getTaskCount read function and displays the result without sending a transaction.
async function getTaskCount() {
    try {
        if (!contract) {
            taskCountStatus.textContent = "Please connect wallet first.";
            return;
        }

        const count = await contract.getTaskCount();
        taskCountStatus.textContent = `Current on-chain task count: ${count.toString()}`;
    } catch (error) {
        taskCountStatus.textContent = `Failed to fetch task count: ${error.message}`;
    }
}

// Register UI event listeners for wallet connect and contract function calls.
connectWalletBtn.addEventListener("click", connectWallet);
createTaskBtn.addEventListener("click", createTask);
getTaskCountBtn.addEventListener("click", getTaskCount);
