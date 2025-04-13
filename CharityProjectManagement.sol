// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract CharityProjectManagement {
    struct Project {
        string name;
        string description;
        address creator;
        uint256 targetAmount;
        uint256 collectedAmount;
        bool completed;
    }

    mapping(uint256 => Project) public projects;
    uint256 public projectCount;

    event ProjectCreated(uint256 id, string name, string description, address creator, uint256 targetAmount);
    event ProjectFunded(uint256 id, address funder, uint256 amount);
    event ProjectCompleted(uint256 id);

    function createProject(string memory _name, string memory _description, uint256 _targetAmount) public {
        projectCount++;
        projects[projectCount] = Project(_name, _description, msg.sender, _targetAmount, 0, false);
        emit ProjectCreated(projectCount, _name, _description, msg.sender, _targetAmount);
    }

    function fundProject(uint256 _id, uint256 _amount) public {
        Project storage project = projects[_id];
        require(!project.completed, "Project already completed");
        project.collectedAmount += _amount;
        emit ProjectFunded(_id, msg.sender, _amount);
    }

    function completeProject(uint256 _id) public {
        Project storage project = projects[_id];
        require(project.creator == msg.sender, "Not the project creator");
        require(project.collectedAmount >= project.targetAmount, "Target amount not reached");
        project.completed = true;
        emit ProjectCompleted(_id);
    }

    function getProject(uint256 _id) public view returns (string memory, string memory, address, uint256, uint256, bool) {
        Project memory project = projects[_id];
        return (project.name, project.description, project.creator, project.targetAmount, project.collectedAmount, project.completed);
    }
}