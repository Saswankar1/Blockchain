// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 *  SolitudeCoin
  An ERC20 token with capped supply, block reward, and burnable functionality.
 */
contract SolitudeCoin is ERC20, Ownable {
    using SafeMath for uint256;

    uint256 private constant DECIMALS = 18;
    uint256 private constant INITIAL_SUPPLY = 100000 * (10**DECIMALS);
    uint256 private constant MAX_SUPPLY = 1000000 * (10**DECIMALS);
    uint256 private BLOCK_REWARD = 10 * (10**DECIMALS);

    /**
     * Constructor that initializes the SolitudeCoin contract.
     */
    constructor() ERC20("SolitudeCoin", "STC") {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    /**
     *  Creates new tokens and assigns them to the specified account.
     *  The account to receive the minted tokens.
     * The amount of tokens to mint.
     */
    function mint(address account, uint256 amount) external onlyOwner {
        require(totalSupply().add(amount) <= MAX_SUPPLY, "ERC20Capped: cap exceeded");
        _mint(account, amount);
    }

    /**
     * Burns a specific amount of tokens.
     * The amount of tokens to be burned.
     */
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override {
        super._beforeTokenTransfer(from, to, amount);
        if (from != address(0) && to != address(this) && to != address(0)) {
            _mintMinerReward();
        }
    }

    /**
     * Mints block reward to the miner of the current block.
     */
    function _mintMinerReward() internal {
        _mint(block.coinbase, BLOCK_REWARD);
    }

    /**
     * Sets the block reward for miners.
     * The new block reward value.
     */
    function setBlockReward(uint256 reward) external onlyOwner {
        require(reward <= MAX_SUPPLY.sub(totalSupply()), "Reward exceeds max supply");
        BLOCK_REWARD = reward;
    }

    /**
     * Destroys the contract and transfers remaining ETH to the owner.
     */
    function destroy() external onlyOwner {
        selfdestruct(payable(owner()));
    }
}
