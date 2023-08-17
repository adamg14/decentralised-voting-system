// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Election{

    struct Candidate{
        string name;
        string party;
    }

    mapping(string => uint256) private votingResults;
    // mapping to keep track of the address that have voted in the election - to prevent a single address voting multiple times
    mapping(address => bool) public voted;
    address immutable owner;

    constructor(){
        owner = msg.sender;
        // initalise the owner of the smart contract as the person that
        votingResults["Candidate A"] = 0;
        votingResults["Candidate B"] = 0;
    }

    // payable function to get the address of the sender
    function vote(string memory name) public{
        // compare the hashes of the strings
        require(keccak256(abi.encodePacked(name)) == keccak256(abi.encodePacked("Candidate A"))
        || keccak256(abi.encodePacked(name)) == keccak256(abi.encodePacked("Candidate B")),
        "Entity you are trying to vote for is not a candidate.");
        votingResults[name] += 1;
    }
}