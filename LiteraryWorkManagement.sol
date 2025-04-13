// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract LiteraryWorkManagement {
    struct LiteraryWork {
        string title;
        string author;
        string genre;
        uint256 publicationYear;
        address[] readers;
    }

    mapping(uint256 => LiteraryWork) public literaryWorks;
    uint256 public workCount;

    event WorkAdded(uint256 id, string title, string author, string genre, uint256 publicationYear);
    event ReaderAdded(uint256 workId, address reader);

    function addLiteraryWork(string memory _title, string memory _author, string memory _genre, uint256 _publicationYear) public {
        workCount++;
        literaryWorks[workCount] = LiteraryWork(_title, _author, _genre, _publicationYear, new address[](0));
        emit WorkAdded(workCount, _title, _author, _genre, _publicationYear);
    }

    function addReader(uint256 _workId) public {
        LiteraryWork storage work = literaryWorks[_workId];
        require(!isReaderAdded(_workId, msg.sender), "Already a reader");
        work.readers.push(msg.sender);
        emit ReaderAdded(_workId, msg.sender);
    }

    function isReaderAdded(uint256 _workId, address _reader) public view returns (bool) {
        LiteraryWork memory work = literaryWorks[_workId];
        for (uint256 i = 0; i < work.readers.length; i++) {
            if (work.readers[i] == _reader) {
                return true;
            }
        }
        return false;
    }

    function getLiteraryWork(uint256 _workId) public view returns (string memory, string memory, string memory, uint256, address[] memory) {
        LiteraryWork memory work = literaryWorks[_workId];
        return (work.title, work.author, work.genre, work.publicationYear, work.readers);
    }
}