// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Context.sol";

contract KimboTrainingStake is Context {
    IERC1155 public nftToken;
    IERC20 public rewardToken;

    mapping(address => uint256) public stakedTokens;

    event Staked(address indexed user, uint256 tokenId, uint256 amount);
    event Claimed(address indexed user, uint256 amount);

    constructor(address _nftToken, address _rewardToken) {
        nftToken = IERC1155(_nftToken); //Set token
        rewardToken = IERC20(_rewardToken); //Set token
    }

    function stake(uint256 tokenId, uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");
        require(nftToken.balanceOf(_msgSender(), tokenId) >= amount, "Insufficient balance");
        
        nftToken.safeTransferFrom(_msgSender(), address(this), tokenId, amount, "");
        stakedTokens[_msgSender()] += amount;
        
        emit Staked(_msgSender(), tokenId, amount);
    }

    function claim() external {
        uint256 amount = stakedTokens[_msgSender()];
        require(amount > 0, "No tokens staked");

        delete stakedTokens[_msgSender()];

        // Reward calculation logic can be added here, this is just an example
        uint256 rewardAmount = 1; // Placeholder amount
        
        rewardToken.transfer(_msgSender(), rewardAmount);
        
        emit Claimed(_msgSender(), rewardAmount);
    }

    function renounce(uint256 tokenId, uint256 amount) external {
        require(stakedTokens[_msgSender()] >= amount, "Insufficient staked amount");

        nftToken.safeTransferFrom(address(this), _msgSender(), tokenId, amount, "");
        stakedTokens[_msgSender()] -= amount;
        
        emit Claimed(_msgSender(), amount);
    }
}
