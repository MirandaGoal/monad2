// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract OnlineCourseManagement {
    struct Course {
        string title;
        string description;
        string instructor;
        uint256 duration; // in hours
        address[] students;
    }

    mapping(uint256 => Course) public courses;
    uint256 public courseCount;

    event CourseCreated(uint256 id, string title, string description, string instructor, uint256 duration);
    event StudentEnrolled(uint256 courseId, address student);

    function createCourse(string memory _title, string memory _description, string memory _instructor, uint256 _duration) public {
        courseCount++;
        courses[courseCount] = Course(_title, _description, _instructor, _duration, new address[](0));
        emit CourseCreated(courseCount, _title, _description, _instructor, _duration);
    }

    function enrollInCourse(uint256 _courseId) public {
        Course storage course = courses[_courseId];
        require(!isStudentEnrolled(_courseId, msg.sender), "Already enrolled");
        course.students.push(msg.sender);
        emit StudentEnrolled(_courseId, msg.sender);
    }

    function isStudentEnrolled(uint256 _courseId, address _student) public view returns (bool) {
        Course memory course = courses[_courseId];
        for (uint256 i = 0; i < course.students.length; i++) {
            if (course.students[i] == _student) {
                return true;
            }
        }
        return false;
    }

    function getCourse(uint256 _courseId) public view returns (string memory, string memory, string memory, uint256, address[] memory) {
        Course memory course = courses[_courseId];
        return (course.title, course.description, course.instructor, course.duration, course.students);
    }
}