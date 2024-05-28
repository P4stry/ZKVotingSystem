// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "zk-merkle-tree/contracts/ZKTree.sol";

contract ZKTreeVote is ZKTree {
    address public owner;
    mapping(address => bool) public validators;
    mapping(uint256 => bool) uniqueHashes;
    uint numOptions;
    mapping(uint => uint) optionCounter;

    event RegisterValidator(address indexed validator);
    event RegisterCommitment(uint256 uniqueHashes);
    event Vote(uint option, bytes32 nullifierHash);

    constructor(uint32 _levels, IHasher _hasher, IVerifier _verifier, uint _numOptions) ZKTree(_levels, _hasher, _verifier) {
        owner = msg.sender;
        numOptions = _numOptions;
        for (uint i = 0; i <= numOptions; i++) optionCounter[i] = 0;
    }

    function registerValidator(address _validator) external {
        require(msg.sender == owner, "Only owner can add validator!");
        require(!validators[_validator], "Validator already registered!");
        validators[_validator] = true;
        emit RegisterValidator(_validator);
    }

    function registerCommitment(uint256 _uniqueHash, uint256 _commitment
    ) external {
        require(validators[msg.sender], "Only validator can commit!");
        require(
            !uniqueHashes[_uniqueHash],
            "This ID Card number is already used!"
        );
        _commit(bytes32(_commitment));
        uniqueHashes[_uniqueHash] = true;
        emit RegisterCommitment(_uniqueHash);
    }

    function vote(uint _option, uint256 _nullifier, uint256 _root, uint[2] memory _proof_a, uint[2][2] memory _proof_b, uint[2] memory _proof_c) external {
        require(_option <= numOptions, "Invalid option!");
        _nullify(bytes32(_nullifier), bytes32(_root), _proof_a, _proof_b, _proof_c);
        optionCounter[_option] = optionCounter[_option] + 1;
        emit Vote(_option, bytes32(_nullifier));
    }

    function getOptionCounter(uint _option) external view returns (uint) {
        return optionCounter[_option];
    }
}
