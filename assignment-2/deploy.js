// Import Hardhat Runtime Environment.
const hre = require("hardhat");
require("dotenv").config();

// Main deployment function.
async function main() {
    // Read required environment values for Polygon Mumbai RPC and deployer account.
    const privateKey = process.env.PRIVATE_KEY;
    const alchemyApiKey = process.env.ALCHEMY_API_KEY;

    // Validate that placeholders are set before deployment.
    if (!privateKey || !alchemyApiKey) {
        throw new Error("Please set PRIVATE_KEY and ALCHEMY_API_KEY in a .env file.");
    }

    // Print network context before deployment.
    console.log("Deploying to network:", hre.network.name);

    // Get contract factory for the TaskTracker contract.
    const TaskTracker = await hre.ethers.getContractFactory("TaskTracker");

    // Deploy a new instance of TaskTracker.
    const taskTracker = await TaskTracker.deploy();

    // Wait for deployment transaction to be mined.
    await taskTracker.waitForDeployment();

    // Read and display deployed contract address.
    const contractAddress = await taskTracker.getAddress();
    console.log("TaskTracker deployed at:", contractAddress);
}

// Handle script execution and errors.
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
