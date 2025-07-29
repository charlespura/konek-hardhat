// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TodoList {
    struct Task {
        string description;
        bool isCompleted;
    }

    mapping(address => Task[]) private tasks;

    event TaskAdded(address indexed user, uint256 taskId, string description);
    event TaskCompleted(address indexed user, uint256 taskId);

    function addTask(string memory _description) external {
        tasks[msg.sender].push(Task(_description, false));
        emit TaskAdded(msg.sender, tasks[msg.sender].length - 1, _description);
    }

    function completeTask(uint256 _taskId) external {
        require(_taskId < tasks[msg.sender].length, "Invalid task ID");
        require(!tasks[msg.sender][_taskId].isCompleted, "Already completed");
        tasks[msg.sender][_taskId].isCompleted = true;
        emit TaskCompleted(msg.sender, _taskId);
    }

    function getTask(uint256 _taskId) external view returns (string memory, bool) {
        require(_taskId < tasks[msg.sender].length, "Invalid task ID");
        Task memory t = tasks[msg.sender][_taskId];
        return (t.description, t.isCompleted);
    }

    function getAllTasks() external view returns (Task[] memory) {
        return tasks[msg.sender];
    }

    function getTaskCount() external view returns (uint256) {
        return tasks[msg.sender].length;
    }
}
