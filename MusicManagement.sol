// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract MusicManagement {
    struct Song {
        string title;
        string artist;
        string album;
        uint256 releaseDate;
        address[] listeners;
    }

    mapping(uint256 => Song) public songs;
    uint256 public songCount;

    event SongAdded(uint256 id, string title, string artist, string album, uint256 releaseDate);
    event ListenerAdded(uint256 songId, address listener);

    function addSong(string memory _title, string memory _artist, string memory _album) public {
        songCount++;
        songs[songCount] = Song(_title, _artist, _album, block.timestamp, new address[](0));
        emit SongAdded(songCount, _title, _artist, _album, block.timestamp);
    }

    function addListener(uint256 _songId) public {
        Song storage song = songs[_songId];
        require(!isListenerAdded(_songId, msg.sender), "Already a listener");
        song.listeners.push(msg.sender);
        emit ListenerAdded(_songId, msg.sender);
    }

    function isListenerAdded(uint256 _songId, address _listener) public view returns (bool) {
        Song memory song = songs[_songId];
        for (uint256 i = 0; i < song.listeners.length; i++) {
            if (song.listeners[i] == _listener) {
                return true;
            }
        }
        return false;
    }

    function getSong(uint256 _songId) public view returns (string memory, string memory, string memory, uint256, address[] memory) {
        Song memory song = songs[_songId];
        return (song.title, song.artist, song.album, song.releaseDate, song.listeners);
    }
}