// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Voting {

    bool voting = false;

    // setting the owner of the contract
    address public owner;
    constructor(){
        owner = msg.sender;
        voters[owner].weightage = 2;
    }

    // Voter
    struct Voter{
        uint weightage;
        bool voted;
        uint vote_id;
    }
    // mapping of voters
    mapping(address => Voter) public voters;

    // candidates struct
    struct candidate{
        bytes32 name;
        uint vote;
    }
    // array of participants
    candidate[] public candidates;

    //this function defines the addresses of participants
    function addPartcicpants(bytes32[] memory candidatesNames) public {
        require(msg.sender == owner, "Only the owner can add candidates");
        for (uint i = 0; i < candidatesNames.length; i++) {
            candidates.push(candidate(candidatesNames[i], 0));
        }
    }

    // to start the voting process
    function startVoting() public {
        require(msg.sender == owner, "Only the owner can start the voting process");
        voting  = true;
    }

    //this function is used to cast the vote 
    function castVote(uint candidate_id) public {
        require(voting, "Voting has ended");
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "Yu have already voted");
        require(candidate_id < candidates.length, "Invalid Candidate");

        sender.voted = true;
        sender.vote_id = candidate_id;
        if(msg.sender == owner){
            candidates[candidate_id].vote += 2;
        }else{
            candidates[candidate_id].vote++;
        }
        
    }

    //this function ends the process of voting
    function endVoting() public {
        require(msg.sender == owner, "Only the owner can start the voting process");
        voting  = false;
    }

    
    //this function returns the winner
    function showResult() public view returns (bytes32[] memory, uint winner_vote) {
        bytes32[] memory winners;
        uint winner_index;

    // find the winner index and max vote
        for(uint i=0; i<candidates.length; i++){
            if(candidates[i].vote > candidates[winner_index].vote){
                winner_index = i;
                winner_vote = candidates[i].vote;
            }
        }

    // no of winners
    uint winner_count;
    for(uint i=0; i<candidates.length; i++){
            if(candidates[i].vote == candidates[winner_index].vote){
                winner_count++;
            }
    }

    // adding winners to the array of winners
    winners = new bytes32[](winner_count);
    uint winnerIndex = 0;
    for(uint i = 0; i < candidates.length; i++){
        if(candidates[i].vote == winner_vote){
            winners[winnerIndex] = candidates[i].name;
            winnerIndex++;
        }
    }

    return (winners, winner_vote);

       
    }

}
