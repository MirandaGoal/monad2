// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract DigitalAssetManagement {
    struct DigitalAsset {
        string name;
        string description;
        string ipfsHash;
        address owner;
        bool available;
    }

    mapping(uint256 => DigitalAsset) public digitalAssets;
    uint256 public assetCount;

    event AssetAdded(uint256 id, string name, string description, string ipfsHash, address owner);
    event AssetBorrowed(uint256 id, address borrower);
    event AssetReturned(uint256 id);

    function addDigitalAsset(string memory _name, string memory _description, string memory _ipfsHash) public {
        assetCount++;
        digitalAssets[assetCount] = DigitalAsset(_name, _description, _ipfsHash, msg.sender, true);
        emit AssetAdded(assetCount, _name, _description, _ipfsHash, msg.sender);
    }

    function borrowAsset(uint256 _id) public {
        DigitalAsset storage asset = digitalAssets[_id];
        require(asset.available, "Asset not available");
        asset.owner = msg.sender;
        asset.available = false;
        emit AssetBorrowed(_id, msg.sender);
    }

    function returnAsset(uint256 _id) public {
        DigitalAsset storage asset = digitalAssets[_id];
        require(asset.owner == msg.sender, "Not the asset owner");
        asset.available = true;
        emit AssetReturned(_id);
    }

    function getDigitalAsset(uint256 _id) public view returns (string memory, string memory, string memory, address, bool) {
        DigitalAsset memory asset = digitalAssets[_id];
        return (asset.name, asset.description, asset.ipfsHash, asset.owner, asset.available);
    }
}