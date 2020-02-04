import "./ERC721.sol";

pragma solidity 0.5.16;

contract Artist is ERC721 {
    mapping(uint => ArtWork) artworks;
    address artist;

    constructor(uint id) public {
        artist = msg.sender;
        _mint(artist, id);
    }
    
    function createArtwork(uint hashIPFS, string memory Name) public returns (ArtWork) {
        ArtWork artContract = new ArtWork(hashIPFS, Name, artist);
        artworks[hashIPFS] = artContract;
        return artContract;
    }
    
    function checkArtwork(uint hashIPFS) public view returns(bool) {
        if(artworks[hashIPFS] == ArtWork(0x0)) {
            return false;
        }
        return true;
    }
}

contract ArtWork is ERC721 {
    address originalArtist;
    string name;
    uint hashIPFS;
    address owner;
    
    constructor(uint ipfsHash, string memory artName, address artist) public {
        originalArtist = msg.sender;
        name = artName;
        owner = artist;
        hashIPFS = ipfsHash;
    }
    
    function setOwner(address newOwner) public {
        if(owner == originalArtist) {
            safeTransferFrom(owner,newOwner,hashIPFS);
        }
    }
}