# Smart Contract-Based Meeting Scheduler

This project demonstrates a decentralized meeting scheduler application built using Ethereum's blockchain technology. The project consists of a Solidity smart contract, a frontend user interface, and a backend event listener.

Features
Decentralized Ownership: The smart contract is governed by an ownership mechanism where the contract deployer is initially set as the owner. Only the owner has the authority to manage the contract's settings and functions.

Session Scheduling: Users can schedule meetings by specifying a meeting link and a start time. The system checks for overlapping sessions before scheduling a new one.

Session Fee and Payment: Each session comes with a predefined session fee. Users are required to send the correct session fee in Ether along with their scheduling request.

Session Duration: The session duration is configurable by the contract owner, ensuring flexibility to adapt to different types of meetings.

Session Overlap Check: The contract checks for overlapping sessions to prevent conflicting schedules.

Event Emission: The contract emits an event when a new session is scheduled, which can be listened to externally.

Withdraw Funds: The contract owner can withdraw the collected Ether funds from the contract.

User Session History: Users can retrieve a list of their scheduled sessions.

Components
Smart Contract (Solidity): The core of the application, containing the business logic, data storage, and access control mechanisms. The smart contract includes functionalities for scheduling sessions, checking overlaps, managing ownership, and more.

Frontend User Interface: A user-friendly interface built using Web3.js, which enables users to interact with the smart contract. Users can schedule sessions, view their session history, and manage their account.

Backend Event Listener: A backend service utilizing Web3.js that listens for the "SessionScheduled" event emitted by the smart contract. This could be used to trigger notifications, send emails, or perform other actions whenever a new session is scheduled.
