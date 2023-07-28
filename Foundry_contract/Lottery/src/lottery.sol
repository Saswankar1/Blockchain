// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Import Chainlink VRF contracts
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

contract Lottery is VRFConsumerBase {
    // Error messages
    error LotteryNotOpen();    // Error for when the lottery is not open
    error InsufficientFee();   // Error for when the fee sent is insufficient

    // Variables
    address private owner;     // Address of the contract owner
    address[] public players;  // Array of player addresses
    uint256 private immutable fee;  // Fee required to enter the lottery
    bool public isActive;      // Flag indicating if the lottery is active
    uint256 public prizePool;  // Accumulated prize pool amount

    bytes32 internal keyHash; // identifies which Chainlink oracle to use
    uint internal random_fee;        // fee to get random number
    uint public randomResult;

    // Constructor
    constructor(uint256 _fee)
        VRFConsumerBase(
            0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625, 
            0x779877A7B0D9E8603169DdbD7836e478b4624789  
        )
    {
        owner = msg.sender;
        fee = _fee;
        isActive = false;
        prizePool = 0;

        keyHash = 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c;
        random_fee = 0.25 * 10 ** 18; 
    }

    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can access this function");
        _;
    }

    // Events
    event LotteryStarted(address indexed player);     // Event emitted when the lottery is started
    event WinnerPicked(address indexed winner, uint256 prize);    // Event emitted when a winner is picked

    // Functions
    function startLottery() external payable {
        require(!isActive, "Lottery is already active");   // Check if the lottery is not already active
        require(msg.value == fee, "Insufficient fee");     // Check if the sent fee is sufficient

        players.push(msg.sender);   // Add the player to the array
        prizePool += msg.value;     // Add the fee to the prize pool
        isActive = true;            // Set the lottery as active

        emit LotteryStarted(msg.sender);    // Emit the LotteryStarted event
    }

    function pickWinner() public onlyOwner {
        require(isActive, "Lottery is not active");     // Check if the lottery is active
        require(players.length > 0, "No players in the lottery");    // Check if there are any players

        uint256 winnerIndex = randomResult % players.length;   // Get the winner index from the random number

        address winner = players[winnerIndex];   // Get the winner address

        payable(winner).transfer(prizePool);     // Transfer the prize pool to the winner
        prizePool = 0;                           // Reset the prize pool to zero
        isActive = false;                        // Set the lottery as inactive

        emit WinnerPicked(winner, prizePool);     // Emit the WinnerPicked event
    }

    function getRandomNumber() public returns (bytes32 requestId) {
        require(LINK.balanceOf(address(this)) >= random_fee, "Not enough LINK in contract");
        return requestRandomness(keyHash, random_fee);
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
        randomResult = randomness;
        pickWinner();
    }

    function getPlayers() external view returns (address[] memory) {
        return players;    // Return the array of players
    }
}
