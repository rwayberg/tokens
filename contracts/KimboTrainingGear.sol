
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extentions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract KimboTrainingGear is ERC1155, ERC1155Burnable, Ownable {
    uint256 public constant LEASH = 0;
    uint256 public constant HARNESS = 1;
    uint256 public constant THORS_HAMMER = 2;
    uint256 public constant BOWL = 3;
    uint256 public constant BACKPACK = 4;

//replace with IPFS files
//create collection json
    constructor() public ERC1155("https://ipfs.io/ips/HASH/{id}.json") {
        _mint(msg.sender, LEASH, 10**18, "");
        _mint(msg.sender, HARNESS, 10**27, "");
        _mint(msg.sender, THORS_HAMMER, 1, "");
        _mint(msg.sender, BOWL, 10**9, "");
        _mint(msg.sender, BACKPACK, 10**9, "");
    }
    //Override the URI function to provide token-specific metadata - OPENSEA
    function uri{uint256 _tokenid}
     public pure override returns (string memory) {
        return string(abi.encodePacked("https://ipfs.io/ipfs/HASH/", Strings.toString(_tokenid), ".json"));
    }

    //Provide a URI for the collection - OPENSEA
    function contractURI public pure returns (string memory) {
        return "https://ipfs.io/ipfs/HASH/collection.json"
    }

    //air drop?

    //Override to enforce burnable??
    function _beforeTokenTransfer(
        address operator,
        address from, 
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal override {
        super._beforeTokenTransfer(operator, from, to, ids, amount, data);
        require (
            msg.sender == owner() || to address(0),
            "Token cannot be transferred, only burned"
        );
    } //This will user super._beforeTokenTransfer to run original code before ovverride
}