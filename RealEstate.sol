// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/utils/Strings.sol";

contract RealEstate {
    bool public ended;
    uint256 public endTime;
    uint256 public maxBid;
    address public maxBuyer;
    address public seller;
    string public propertyName;
    uint256 public initialPrice;

    constructor(uint256 ending, string memory name, uint256 price) payable {
        ended = false;
        endTime = ending;
        seller = msg.sender;
        propertyName = name;
        initialPrice = price;
        maxBuyer = seller;
        maxBid = 0;
    }

    function getTime() public view returns(uint256) {
        return block.timestamp; // This returns the current time
    }

    function setSeller(address newSeller) public {
        require (msg.sender == seller); 
        require (!ended); 
        seller = newSeller;
    }

    function propertyBid() public payable {
        require (ended == false); // Checks whether the bid hasn't ended
        require (msg.value > maxBid && msg.value >= initialPrice); // Ensures that the new bid is greater than the previous bid
        payable (maxBuyer).transfer(maxBid); // Pays back the previous bid to the previous bidder
        maxBid = msg.value; // Changes the bid to the current bid
        maxBuyer = msg.sender; // Changes the bidder to the current bidder
    }

    function cancelAuction() public {
        require (msg.sender == seller);
        require (!ended);
        ended = true;
        payable (maxBuyer).transfer(maxBid); // Pays back the previous bid to the previous bidder
    }

    function settleProperty() public payable {
        require (ended == false); // Checks whether the bid hasn't ended
        require (getTime() >= endTime); // Checks whether the current time has passed the end time
        ended = true; // Indicates that the bid has ended
        payable (maxBuyer).transfer(maxBid); // Pays back the current bid to the current bidder indicating that they have won
    }

    function extendBid(uint256 addSeconds) public {
        require(msg.sender == seller , "Only for seller to update"); // Only the seller can access this function
        require(!ended, "Auction already ended, cannot extend further!"); // Ensures that the bid has not ended

        endTime += addSeconds; // Increases the end time for the bid
    }

    function viewProperty() public view returns(string memory) {
        string memory description = string.concat("The name of the Property is ", propertyName, " and is worth $", Strings.toString(initialPrice)); // Creates a new string
        return description; // Returns the string
    }

    function updateInfo(string newName, uint256 newPrice) public {
        require(msg.sender == seller);
        require(!ended); 
        propertyName = newName;
        initialPrice = newPrice;
    }

    function viewCurrentBid() public view returns(string memory) {
        string memory currentBid = string.concat("The current bid on this Property is $", Strings.toString(maxBid)); // Creates a new string
        return currentBid; // Returns the string
    }
}
