// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract CulturalEventManagement {
    struct Event {
        string name;
        string location;
        uint256 startDate;
        uint256 endDate;
        address organizer;
        address[] attendees;
    }

    mapping(uint256 => Event) public events;
    uint256 public eventCount;

    event EventCreated(uint256 id, string name, string location, uint256 startDate, uint256 endDate, address organizer);
    event AttendeeRegistered(uint256 eventId, address attendee);

    function createEvent(string memory _name, string memory _location, uint256 _startDate, uint256 _endDate) public {
        eventCount++;
        events[eventCount] = Event(_name, _location, _startDate, _endDate, msg.sender, new address[](0));
        emit EventCreated(eventCount, _name, _location, _startDate, _endDate, msg.sender);
    }

    function registerAttendee(uint256 _eventId) public {
        Event storage event_ = events[_eventId];
        require(!isAttendeeRegistered(_eventId, msg.sender), "Already registered");
        event_.attendees.push(msg.sender);
        emit AttendeeRegistered(_eventId, msg.sender);
    }

    function isAttendeeRegistered(uint256 _eventId, address _attendee) public view returns (bool) {
        Event memory event_ = events[_eventId];
        for (uint256 i = 0; i < event_.attendees.length; i++) {
            if (event_.attendees[i] == _attendee) {
                return true;
            }
        }
        return false;
    }

    function getEvent(uint256 _eventId) public view returns (string memory, string memory, uint256, uint256, address, address[] memory) {
        Event memory event_ = events[_eventId];
        return (event_.name, event_.location, event_.startDate, event_.endDate, event_.organizer, event_.attendees);
    }
}