// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
// import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155ClaimPhasesV2.sol";
// import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155LazyMintableV2.sol";
//import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Enumerable.sol";
//import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Royalties.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract KimboTrainerPass is ERC1155, ERC1155Burnable, Ownable { //ERC1155Supply, ERC1155ClaimPhasesV2, ERC1155LazyMintableV2, ERC1155Enumerable, ERC1155Royalties, ERC1155Burnable {
    string private _imageURI;

    constructor(string memory imageURIParam) Ownable(msg.sender) ERC1155("") {
        _imageURI = imageURIParam;
    }

    function setImageURI(string memory imageURIParam) external {
        require(msg.sender == owner(), "Only owner can set image URI");
        _imageURI = imageURIParam;
    }

    function imageURI(uint256 tokenId) public view returns (string memory) {
        require(tokenId == 0, "Invalid token ID");
        return _imageURI;
    }

    function mint(address account, uint256 id, uint256 amount, bytes memory data) public {
        require(msg.sender == owner(), "Only owner can mint tokens");
        _mint(account, id, amount, data);
    }

    // function setClaimConditions(uint256 phaseId, uint256 conditionId, uint256[] memory tokenIds, uint256[] memory amounts) external {
    //     require(msg.sender == owner, "Only owner can set claim conditions");
    //     _setClaimConditions(phaseId, conditionId, tokenIds, amounts);
    // }

    // function setLazyMint(address to, uint256 id, uint256 amount, bytes memory data) external {
    //     require(msg.sender == owner, "Only owner can perform lazy mint");
    //     _lazyMint(to, id, amount, data);
    // }

    //function setRoyalties(uint256 tokenId, address payable[] memory recipients, uint256[] memory bps) external {
    //    require(msg.sender == owner, "Only owner can set royalties");
    //    _setRoyalties(tokenId, recipients, bps);
    //}

    function _update(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory values
    ) internal virtual override {
        require (
            msg.sender == owner() || to == address(0),
            "Token cannot be transferred, only burned"
        );
        super._update(from, to, ids, values);
    }

    // function supportsInterface(bytes4 interfaceId) public view virtual override(ERC1155Enumerable) returns (bool) {
    //     return super.supportsInterface(interfaceId);
    // }
}
