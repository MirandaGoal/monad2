// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract EducationalMaterialManagement {
    struct Material {
        string title;
        string description;
        string ipfsHash;
        address uploader;
        uint256 uploadDate;
    }

    mapping(uint256 => Material) public materials;
    uint256 public materialCount;

    event MaterialUploaded(uint256 id, string title, string description, string ipfsHash, address uploader, uint256 uploadDate);

    function uploadMaterial(string memory _title, string memory _description, string memory _ipfsHash) public {
        materialCount++;
        materials[materialCount] = Material(_title, _description, _ipfsHash, msg.sender, block.timestamp);
        emit MaterialUploaded(materialCount, _title, _description, _ipfsHash, msg.sender, block.timestamp);
    }

    function getMaterial(uint256 _id) public view returns (string memory, string memory, string memory, address, uint256) {
        Material memory material = materials[_id];
        return (material.title, material.description, material.ipfsHash, material.uploader, material.uploadDate);
    }
}