// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TaskTracker {
    struct Task {
        string description;
        bool completed;
        uint256 createdAt;
    }

    Task[] private tasks;

    event TaskCreated(uint256 indexed taskId, string description, uint256 createdAt);
    event TaskStatusUpdated(uint256 indexed taskId, bool completed);
    event TaskDescriptionUpdated(uint256 indexed taskId, string newDescription);

    /// @notice Creates a new task and stores it on-chain.
    /// @param description The task text that describes what needs to be done.
    function createTask(string memory description) public {
        require(bytes(description).length > 0, "Description cannot be empty");

        tasks.push(Task({description: description, completed: false, createdAt: block.timestamp}));
        uint256 newTaskId = tasks.length - 1;

        emit TaskCreated(newTaskId, description, block.timestamp);
    }

    /// @notice Updates the completion status of an existing task.
    /// @param taskId The index of the task in the tasks array.
    /// @param completed The new completion status to store.
    function setTaskStatus(uint256 taskId, bool completed) public {
        require(taskId < tasks.length, "Invalid task ID");

        tasks[taskId].completed = completed;

        emit TaskStatusUpdated(taskId, completed);
    }

    /// @notice Updates the description text for an existing task.
    /// @param taskId The index of the task to update.
    /// @param newDescription The replacement text for the task description.
    function updateTaskDescription(uint256 taskId, string memory newDescription) public {
        require(taskId < tasks.length, "Invalid task ID");
        require(bytes(newDescription).length > 0, "Description cannot be empty");

        tasks[taskId].description = newDescription;

        emit TaskDescriptionUpdated(taskId, newDescription);
    }

    /// @notice Reads all details for a single task.
    /// @param taskId The index of the task to read.
    /// @return description The task text.
    /// @return completed Whether the task is completed.
    /// @return createdAt The timestamp when the task was created.
    function getTask(uint256 taskId)
        public
        view
        returns (string memory description, bool completed, uint256 createdAt)
    {
        require(taskId < tasks.length, "Invalid task ID");

        Task memory task = tasks[taskId];
        return (task.description, task.completed, task.createdAt);
    }

    /// @notice Returns total number of tasks stored on-chain.
    /// @return The length of the tasks array.
    function getTaskCount() public view returns (uint256) {
        return tasks.length;
    }
}
