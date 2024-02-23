// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GKMBToken is ERC20 {
    string private _imageURI;

    constructor(string memory imageURI) ERC20("gKimbo", "GKMB") {
        _imageURI = imageURI;
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function imageURI() public view returns (string memory) {
        return _imageURI;
    }
}
