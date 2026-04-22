# Assignment 1 - Smart Contract Development

## Contract Purpose
The `TaskTracker` contract is a simple on-chain task management system. It lets users create tasks, update status, edit descriptions, and read task data from the blockchain.

## Function-by-Function Logic

### `createTask(string description)`
- Creates a new task with a non-empty description.
- Sets the default completion status to `false`.
- Stores creation timestamp using `block.timestamp`.
- Emits `TaskCreated` after successful state update.

### `setTaskStatus(uint256 taskId, bool completed)`
- Updates completion status for a specific task.
- Validates `taskId` to avoid out-of-bounds access.
- Emits `TaskStatusUpdated` after successful update.

### `updateTaskDescription(uint256 taskId, string newDescription)`
- Replaces the description of an existing task.
- Checks valid `taskId` and non-empty new description.
- Emits `TaskDescriptionUpdated` after updating storage.

### `getTask(uint256 taskId)`
- Reads one task by index.
- Returns description, completion status, and creation timestamp.
- Reverts if `taskId` does not exist.

### `getTaskCount()`
- Returns total number of tasks currently stored.

## Hardhat Compilation and Deployment (Local)

1. Create a Hardhat project:
   ```bash
   mkdir tasktracker-hardhat
   cd tasktracker-hardhat
   npm init -y
   npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox
   npx hardhat
   ```

2. Copy `contract.sol` into `contracts/TaskTracker.sol`.

3. Compile contract:
   ```bash
   npx hardhat compile
   ```

4. Start local node:
   ```bash
   npx hardhat node
   ```

5. Deploy contract from another terminal (using a deploy script):
   ```bash
   npx hardhat run scripts/deploy.js --network localhost
   ```

## Screenshot Placeholders
- [Screenshot: compilation]
- [Screenshot: deployment]
