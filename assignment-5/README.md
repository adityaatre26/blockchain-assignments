# Assignment 5 - DAO Smart Contract

## Objective
Implement a basic DAO contract with proposal creation, yes/no voting, and execution based on a configurable threshold.

## DAO Workflow

1. **Create Proposal**
   - A participant calls `createProposal(title, description, votingDurationSeconds)`.
   - Contract stores proposal with deadline.
   - `ProposalCreated` event is emitted.

2. **Vote On Proposal**
   - Participants call `vote(proposalId, support)` before deadline.
   - `support = true` means yes vote.
   - `support = false` means no vote.
   - Each address can vote only once per proposal.
   - `VoteCast` event is emitted.

3. **Execute Proposal**
   - After voting deadline, any user calls `executeProposal(proposalId)`.
   - Proposal passes only when:
     - `yesVotes >= executionThreshold`
     - `yesVotes > noVotes`
   - Proposal is marked executed regardless of pass/fail outcome.
   - `ProposalExecuted` event is emitted with pass status.

## Voting Mechanism Explained
- The contract tracks votes per proposal in `yesVotes` and `noVotes`.
- Duplicate voting is prevented through `hasVoted[proposalId][voter]`.
- Voting is time-bound via `votingDeadline`.
- Threshold ensures minimum governance participation for valid approval.

## Main Functions
- `createProposal(...)`
- `vote(...)`
- `executeProposal(...)`
- `getVoteTotals(...)`

## Screenshot Placeholders
- [Screenshot: proposal creation transaction]
- [Screenshot: voting transaction (yes/no)]
- [Screenshot: execute proposal transaction]
- [Screenshot: event logs in explorer]
