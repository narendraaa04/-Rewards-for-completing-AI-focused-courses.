// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LearnToEarn {
    address public owner;
    mapping(address => uint256) public rewards;

    event CourseCompleted(address indexed user, uint256 reward);
    event RewardClaimed(address indexed user, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function rewardUser(address _user, uint256 _amount) external onlyOwner {
        rewards[_user] += _amount;
        emit CourseCompleted(_user, _amount);
    }

    function claimReward() external {
        uint256 reward = rewards[msg.sender];
        require(reward > 0, "No rewards to claim");

        rewards[msg.sender] = 0;
        payable(msg.sender).transfer(reward);

        emit RewardClaimed(msg.sender, reward);
    }

    receive() external payable {}
}
