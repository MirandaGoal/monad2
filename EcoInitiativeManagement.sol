// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract EcoInitiativeManagement {
    struct Initiative {
        string name;
        string description;
        string location;
        uint256 startDate;
        uint256 endDate;
        address organizer;
        bool completed;
    }

    mapping(uint256 => Initiative) public initiatives;
    uint256 public initiativeCount;

    event InitiativeCreated(uint256 id, string name, string description, string location, uint256 startDate, uint256 endDate, address organizer);
    event InitiativeCompleted(uint256 id);

    function createInitiative(string memory _name, string memory _description, string memory _location, uint256 _startDate, uint256 _endDate) public {
        initiativeCount++;
        initiatives[initiativeCount] = Initiative(_name, _description, _location, _startDate, _endDate, msg.sender, false);
        emit InitiativeCreated(initiativeCount, _name, _description, _location, _startDate, _endDate, msg.sender);
    }

    function completeInitiative(uint256 _id) public {
        Initiative storage initiative = initiatives[_id];
        require(initiative.organizer == msg.sender, "Not the organizer");
        initiative.completed = true;
        emit InitiativeCompleted(_id);
    }

    function getInitiative(uint256 _id) public view returns (string memory, string memory, string memory, uint256, uint256, address, bool) {
        Initiative memory initiative = initiatives[_id];
        return (initiative.name, initiative.description, initiative.location, initiative.startDate, initiative.endDate, initiative.organizer, initiative.completed);
    }
}