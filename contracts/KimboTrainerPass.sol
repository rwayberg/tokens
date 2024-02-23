// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155ClaimPhasesV2.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155LazyMintableV2.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Enumerable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Royalties.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";

contract KimboTrainerPass is ERC1155Supply, ERC1155ClaimPhasesV2, ERC1155LazyMintableV2, ERC1155Enumerable, ERC1155Royalties, ERC1155Burnable {
    address public owner;
    string private _imageURI;

    constructor(string memory imageURI) ERC1155("") {
        owner = msg.sender;
        _imageURI = imageURI;
    }

    function setImageURI(string memory imageURI) external {
        require(msg.sender == owner, "Only owner can set image URI");
        _imageURI = imageURI;
    }

    function imageURI(uint256 tokenId) public view returns (string memory) {
        require(tokenId == 0, "Invalid token ID");
        return _imageURI;
    }

    function mint(address account, uint256 id, uint256 amount, bytes memory data) public {
        require(msg.sender == owner, "Only owner can mint tokens");
        _mint(account, id, amount, data);
    }

    function setClaimConditions(uint256 phaseId, uint256 conditionId, uint256[] memory tokenIds, uint256[] memory amounts) external {
        require(msg.sender == owner, "Only owner can set claim conditions");
        _setClaimConditions(phaseId, conditionId, tokenIds, amounts);
    }

    function setLazyMint(address to, uint256 id, uint256 amount, bytes memory data) external {
        require(msg.sender == owner, "Only owner can perform lazy mint");
        _lazyMint(to, id, amount, data);
    }

    function setRoyalties(uint256 tokenId, address payable[] memory recipients, uint256[] memory bps) external {
        require(msg.sender == owner, "Only owner can set royalties");
        _setRoyalties(tokenId, recipients, bps);
    }

    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual override(ERC1155, ERC1155Enumerable) {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC1155Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
