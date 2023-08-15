// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ownable {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the address provided by the deployer as the initial owner.
     */
    constructor(address initialOwner) {
        _transferOwnership(initialOwner);
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        require(owner() == msg.sender);
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby disabling any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(owner() == msg.sender);
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}


contract MeetCreation is Ownable {
    uint256 public sessionFee;
    uint256 public sessionDuration = 900 seconds;
    Session[] public sessions;

    event SessionScheduled(address indexed user, string meetingLink, uint256 startTime, uint256 endTime);   
    struct Session {
        address user;
        string meetingLink;
        uint256 startTime;
        uint256 endTime;
    }

    
    constructor(uint256 _sessionFee) Ownable (msg.sender) {
        sessionFee = _sessionFee;
    }
    
    function isSessionOverlap(uint256 startTime) public view returns (bool) {
        for (uint256 i = 0; i < sessions.length; i++) {
            if (sessions[i].startTime <= startTime && sessions[i].endTime >= startTime) {
                return true; 
            }
        }
        return false; 
    }

    function scheduleSession(string memory meetingLink, uint256 startTime) public payable {
        require(!isSessionOverlap(startTime), "Session overlaps with an existing session");
        require(msg.value == sessionFee, "Payment must be equal to the session fee");
        uint256 endTime = startTime + sessionDuration;
        sessions.push(Session(msg.sender, meetingLink, startTime, endTime));
        emit SessionScheduled(msg.sender, meetingLink, startTime, endTime);
    }

    function withdrawFunds() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    function getUserSessions(address userAddress) public view returns (Session[] memory) {
        uint256 count = 0;

        for (uint256 i = 0; i < sessions.length; i++) {
            if (sessions[i].user == userAddress) {
                count++;
            }
        }

        Session[] memory userSessions = new Session[](count);

        uint256 index = 0;
        for (uint256 i = 0; i < sessions.length; i++) {
            if (sessions[i].user == userAddress) {
                userSessions[index] = sessions[i];
                index++;
            }
        }

        return userSessions;
    }

    function getAllSessions() public view returns (Session[] memory) {
        return sessions;
    }

    function setSessionDuration(uint256 duration) public onlyOwner {
        sessionDuration = duration;
    }
}