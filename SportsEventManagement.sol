// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract SportsEventManagement {
    struct Event {
        string name;
        string location;
        uint256 startDate;
        uint256 endDate;
        address organizer;
        address[] participants;
    }

    mapping(uint256 => Event) public events;
    uint256 public eventCount;

    event EventCreated(uint256 id, string name, string location, uint256 startDate, uint256 endDate, address organizer);
    event ParticipantAdded(uint256 eventId, address participant);

    function createEvent(string memory _name, string memory _location, uint256 _startDate, uint256 _endDate) public {
        eventCount++;
        events[eventCount] = Event(_name, _location, _startDate, _endDate, msg.sender, new address[](0));
        emit EventCreated(eventCount, _name, _location, _startDate, _endDate, msg.sender);
    }

    function addParticipant(uint256 _eventId) public {
        Event storage event_ = events[_eventId];
        require(!isParticipantAdded(_eventId, msg.sender), "Already a participant");
        event_.participants.push(msg.sender);
        emit ParticipantAdded(_eventId, msg.sender);
    }

    function isParticipantAdded(uint256 _eventId, address _participant) public view returns (bool) {
        Event memory event_ = events[_eventId];
        for (uint256 i = 0; i < event_.participants.length; i++) {
            if (event_.participants[i] == _participant) {
                return true;
            }
        }
        return false;
    }

    function getEvent(uint256 _eventId) public view returns (string memory, string memory, uint256, uint256, address, address[] memory) {
        Event memory event_ = events[_eventId];
        return (event_.name, event_.location, event_.startDate, event_.endDate, event_.organizer, event_.participants);
    }
}