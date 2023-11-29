// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "./Strings.sol";

contract RealEstate {
    bool public ended;
    uint256 public endTime;
    uint256 public maxBid;
    address public maxBuyer;
    address public seller;
    string public propertyName;
    uint256 public initialPrice;

    constructor(uint256 ending, string memory name, uint256 price) {
        ended = false;
        endTime = ending;
        seller = msg.sender;
        propertyName = name;
        initialPrice = price;
    }

    function getTime() public view returns(uint256) {
        return block.timestamp;
    }

    function propertyBid() public payable {
        require (ended == false);
        require (msg.value > maxBid);
        payable (maxBuyer).transfer(maxBid);
        maxBid = msg.value;
        maxBuyer = msg.sender;
    }

    function settleProperty() public payable {
        require (ended == false);
        require (getTime() >= endTime);
        ended = true;
        payable (maxBuyer).transfer(maxBid);
    }

    function extendAuction(uint256 addSeconds) public {
        require(msg.sender == seller , "Only for seller to update");
        require(!ended, "Auction already ended, cannot extend further!");

        endTime += addSeconds;

    }

    function viewProperty() public view returns(string memory) {
        string memory description = string.concat("The name of the Property is ", propertyName, " and is worth $", Strings.toString(initialPrice));
        return description;
    }

    function viewCurrentBid() public view returns(string memory) {
        string memory currentBid = string.concat("The current bid on this Property is $", Strings.toString(maxBid));
        return currentBid;
    }

}
