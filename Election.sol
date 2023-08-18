// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Election{

    struct Candidate{
        string name;
        string party;
    }

    mapping(string => uint256) public voteCount;
    // mapping to keep track of the address that have voted in the election - to prevent a single address voting multiple times
    mapping(address => bool) public voted;
    address immutable owner;
    Candidate[] public candidates;

    constructor(){
        // initialise the owner of the election as the address that deployed the smart contract
        // the owner - the government - has control of the election e.g. when to end it
        owner = msg.sender;
        // initialse the vote count for each candidate to 0
        voteCount["Candidate A"] = 0;
        voteCount["Candidate B"] = 0;
        // add each candidate to the list of canidates
        addCandidate("Candidate A", "Party A");
        addCandidate("Candidate B", "Party B");
    }

    // add the candidates in the election
    function addCandidate(string memory name, string memory party) private{
        candidates.push(Candidate(name, party));
    }

    // payable function to get the address of the sender of the transaction
    function vote(string memory name) public{
        // compare the hashes of the strings
        require(keccak256(abi.encodePacked(name)) == keccak256(abi.encodePacked("Candidate A"))
        || keccak256(abi.encodePacked(name)) == keccak256(abi.encodePacked("Candidate B")),
        "Entity you are trying to vote for is not a candidate.");
        // add one vote to the candidate
        voteCount[name] += 1;
    }

    // function for the user to be able to see the list of candidates
    function currentCandidates() view public returns(string[] memory){
        string[] memory candidateNames = new string[](candidates.length);
        for (uint256 i = 0; i < candidates.length; i++){
            candidateNames[i] = candidates[i].name;
        }
        return candidateNames;
    }

    // a function to allow user to see information about a specific candidate
    function candidateInformation(string memory name) view public returns(Candidate memory){
        Candidate memory selectedCandidate;
        for (uint256 i = 0; i < candidates.length; i++){
            if (keccak256(abi.encodePacked(name)) == keccak256(abi.encodePacked(candidates[i].name))){
                selectedCandidate = candidates[i];
            }
        }
        return selectedCandidate;
    }

    // function that returns the total number of votes casted in the election
    function votesCasted() view public returns(uint256){
        uint256 totalVotesCasted = 0;
        for (uint256 i = 0; i < candidates.length; i++){
            totalVotesCasted += voteCount[candidates[i].name];
        }
        return  totalVotesCasted;
    }

    // function to see the vote count of a selected candidate
    function candidateVotes(string memory name) view public returns(uint256){
        return voteCount[name];
    }

    // function to see the current  winner of the election -
    // need a testcase for a tie - need to also display which candidates are tied
    function currentWinner() view public returns(string memory){
        string memory winner;
        uint256 votes = 0;
        for (uint256 i = 0; i < candidates.length; i++){
            if (voteCount[candidates[i].name]> votes){
                winner = candidates[i].name;
                votes = voteCount[candidates[i].name];
            }else if(voteCount[candidates[i].name] == votes){
                winner = "Election tied";
            }
        }
        return winner;
    }
    // stop the election - add an isOwner function that verifies that the address stopping the election is the address that deployed the smart contract
}