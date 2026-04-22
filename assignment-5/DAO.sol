// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleDAO {
    // Proposal structure stores core data needed for DAO governance.
    struct Proposal {
        uint256 id;
        string title;
        string description;
        address proposer;
        uint256 yesVotes;
        uint256 noVotes;
        uint256 votingDeadline;
        bool executed;
    }

    // Mapping from proposal ID to proposal details.
    mapping(uint256 => Proposal) public proposals;

    // Mapping to track whether a voter has already voted on a given proposal.
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    // Total number of proposals created so far.
    uint256 public proposalCount;

    // Minimum number of yes votes required for a proposal to pass.
    uint256 public immutable executionThreshold;

    // Event emitted whenever a new proposal is created.
    event ProposalCreated(
        uint256 indexed proposalId,
        address indexed proposer,
        string title,
        uint256 votingDeadline
    );

    // Event emitted whenever a vote is cast.
    event VoteCast(uint256 indexed proposalId, address indexed voter, bool support, uint256 weight);

    // Event emitted when a proposal is executed.
    event ProposalExecuted(uint256 indexed proposalId, bool passed);

    /// @notice Initializes DAO with an execution threshold for passed proposals.
    /// @param _executionThreshold Number of yes votes required for execution success.
    constructor(uint256 _executionThreshold) {
        require(_executionThreshold > 0, "Threshold must be greater than zero");
        executionThreshold = _executionThreshold;
    }

    /// @notice Creates a new proposal that can be voted on by DAO participants.
    /// @param title Short title for proposal context.
    /// @param description Full details of proposal intent.
    /// @param votingDurationSeconds How long voting remains open from current block time.
    /// @return proposalId The ID of the newly created proposal.
    function createProposal(
        string memory title,
        string memory description,
        uint256 votingDurationSeconds
    ) external returns (uint256 proposalId) {
        require(bytes(title).length > 0, "Title cannot be empty");
        require(bytes(description).length > 0, "Description cannot be empty");
        require(votingDurationSeconds > 0, "Voting duration must be greater than zero");

        proposalCount += 1;
        proposalId = proposalCount;

        proposals[proposalId] = Proposal({
            id: proposalId,
            title: title,
            description: description,
            proposer: msg.sender,
            yesVotes: 0,
            noVotes: 0,
            votingDeadline: block.timestamp + votingDurationSeconds,
            executed: false
        });

        emit ProposalCreated(proposalId, msg.sender, title, block.timestamp + votingDurationSeconds);
    }

    /// @notice Casts a yes/no vote on a proposal before deadline.
    /// @param proposalId Proposal identifier to vote on.
    /// @param support True for yes vote, false for no vote.
    function vote(uint256 proposalId, bool support) external {
        Proposal storage proposal = proposals[proposalId];

        require(proposal.id != 0, "Proposal does not exist");
        require(block.timestamp <= proposal.votingDeadline, "Voting period has ended");
        require(!proposal.executed, "Proposal already executed");
        require(!hasVoted[proposalId][msg.sender], "Address has already voted");

        hasVoted[proposalId][msg.sender] = true;

        if (support) {
            proposal.yesVotes += 1;
        } else {
            proposal.noVotes += 1;
        }

        emit VoteCast(proposalId, msg.sender, support, 1);
    }

    /// @notice Executes a proposal after voting period if threshold logic is satisfied.
    /// @param proposalId Proposal identifier to execute.
    /// @return passed True if yes votes exceed no votes and meet threshold, otherwise false.
    function executeProposal(uint256 proposalId) external returns (bool passed) {
        Proposal storage proposal = proposals[proposalId];

        require(proposal.id != 0, "Proposal does not exist");
        require(block.timestamp > proposal.votingDeadline, "Voting period is still active");
        require(!proposal.executed, "Proposal already executed");

        // Proposal passes only if yes votes meet threshold and exceed no votes.
        passed = proposal.yesVotes >= executionThreshold && proposal.yesVotes > proposal.noVotes;

        proposal.executed = true;

        emit ProposalExecuted(proposalId, passed);
    }

    /// @notice Returns the current yes/no vote totals for a given proposal.
    /// @param proposalId Proposal identifier to inspect.
    /// @return yesVotes Total affirmative votes.
    /// @return noVotes Total negative votes.
    function getVoteTotals(uint256 proposalId) external view returns (uint256 yesVotes, uint256 noVotes) {
        Proposal storage proposal = proposals[proposalId];
        require(proposal.id != 0, "Proposal does not exist");

        return (proposal.yesVotes, proposal.noVotes);
    }
}
