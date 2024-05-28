// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Router {
    struct VoteProposal{
        address contractAddress;
        string name;
        uint numOptions;
        string[] options;
    }

    uint public numVoteProposals;

    mapping(uint => VoteProposal) public voteProposals;

    function registerVoteProposal(address _contractAddress, string memory _name, uint _numOptions, string[] memory _options) public {
        uint id = getUniqueProposalIdentifier();
        VoteProposal storage newVoteProposal = voteProposals[id];
        newVoteProposal.contractAddress = _contractAddress;
        newVoteProposal.name = _name;
        newVoteProposal.numOptions = _numOptions;
        newVoteProposal.options = _options;
    }

    function getVoteProposal(uint id) view public returns (address, string memory, uint, string[] memory){
        VoteProposal storage voteProposal = voteProposals[id];
        return (voteProposal.contractAddress, voteProposal.name, voteProposal.numOptions, voteProposal.options);
    }

    function getUniqueProposalIdentifier() public returns (uint) {
        uint currId = numVoteProposals;
        numVoteProposals++;
        return currId;
    }
}