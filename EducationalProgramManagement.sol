// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract EducationalProgramManagement {
    struct Program {
        string name;
        string description;
        string institution;
        uint256 startDate;
        uint256 endDate;
        address[] students;
    }

    mapping(uint256 => Program) public programs;
    uint256 public programCount;

    event ProgramCreated(uint256 id, string name, string description, string institution, uint256 startDate, uint256 endDate);
    event StudentEnrolled(uint256 programId, address student);

    function createProgram(string memory _name, string memory _description, string memory _institution, uint256 _startDate, uint256 _endDate) public {
        programCount++;
        programs[programCount] = Program(_name, _description, _institution, _startDate, _endDate, new address[](0));
        emit ProgramCreated(programCount, _name, _description, _institution, _startDate, _endDate);
    }

    function enrollInProgram(uint256 _programId) public {
        Program storage program = programs[_programId];
        require(!isStudentEnrolled(_programId, msg.sender), "Already enrolled");
        program.students.push(msg.sender);
        emit StudentEnrolled(_programId, msg.sender);
    }

    function isStudentEnrolled(uint256 _programId, address _student) public view returns (bool) {
        Program memory program = programs[_programId];
        for (uint256 i = 0; i < program.students.length; i++) {
            if (program.students[i] == _student) {
                return true;
            }
        }
        return false;
    }

    function getProgram(uint256 _programId) public view returns (string memory, string memory, string memory, uint256, uint256, address[] memory) {
        Program memory program = programs[_programId];
        return (program.name, program.description, program.institution, program.startDate, program.endDate, program.students);
    }
}