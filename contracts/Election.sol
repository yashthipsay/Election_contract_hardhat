// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

error NotAuthorised(string status);
error NotOwner();

contract Election {
    struct Voter {
        //Define voter details
        bool authorised;
        bool voted;
        uint256 vote;
    }

    struct Candidate {
        //Define candidate details
        string name;
        uint256 voteCount;
    }
    uint256 public totalVotes;
    address immutable i_owner;
    mapping(address => Voter) public voters;
    Candidate[] public candidate;
    address[] public hardhatNode;
    uint256 keyIndex = 0;

    constructor(address _i_owner) {
        i_owner = _i_owner;
    }

    function addAddress(address public_key) public {
        hardhatNode.push(public_key);
        keyIndex++;
    }

    function purpose(string memory reason) public pure returns (string memory) {
        return reason;
    }

    function authorise(address _person) public payable {
        voters[_person].authorised = true;
    }

    function addCandidate(string memory _name) public {
        candidate.push(Candidate(_name, 0));
    }

    function castVote(uint256 _voteIndex, address public_key) public payable {
        require(!voters[public_key].voted);
        if (voters[public_key].authorised != true) {
            revert NotAuthorised("Voter needs to be authorised");
        }
        voters[public_key].vote = _voteIndex;
        voters[public_key].voted = true;
        candidate[_voteIndex].voteCount += 1;
        totalVotes += 1;
    }
}
