// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

error NotAuthorised(string status);
error NotOwner();

contract Election {
    struct Voter {
        bool authorised;
        bool voted;
        uint256 vote;
    }

    struct Candidate {
        string name;
        uint256 voteCount;
    }
    uint256 public totalVotes;
    address immutable i_owner;
    mapping(address => Voter) public voters;
    Candidate[] public candidate;

    constructor() {
        i_owner = msg.sender;
    }

    function purpose(string memory reason) public pure returns (string memory) {
        return reason;
    }

    function authorise(address _person) public payable {
        if (msg.sender != i_owner) {
            revert NotOwner();
        }
        voters[_person].authorised = true;
    }

    function addCandidate(string memory _name) public {
        if (msg.sender != i_owner) {
            revert NotOwner();
        }
        candidate.push(Candidate(_name, 0));
    }

    function castVote(uint256 _voteIndex) public payable {
        require(!voters[msg.sender].voted);
        if (voters[msg.sender].authorised != true) {
            revert NotAuthorised("Voter needs to be authorised");
        }
        voters[msg.sender].vote = _voteIndex;
        voters[msg.sender].voted = true;
        candidate[_voteIndex].voteCount += 1;
        totalVotes += 1;
    }
}
