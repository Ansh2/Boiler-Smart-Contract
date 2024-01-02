/ SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract Auction {
    bool public ended;
    uint public maximum_bid; 
    uint public end_time = 1698983613;
    address public max_bidder; 
    address public seller; 

    // struct Person {
    //     uint age;
    //     uint first_name;
    //     uint last_name;
    
    // }   

    constructor(uint256 ending) {
        ended = false;
        seller = msg.sender;
        end_time = ending;
    }

    //function bid public payable
    // paramaters: no parameters. YOu can use msg.sender for the address
    // anad msg.value for the amount
    // return type: none

     function bid() external payable {
        //conditions to check if auction has ended
        require(ended, "Highest bidder already given price");
        require(getCurrentTime() >= end_time, "Auction time has ended");
        if (msg.value > maximum_bid) {
            maximum_bid = msg.value;
            max_bidder = msg.sender;
        }

        // require(msg.value > maximum_bid, "Bid should be greater than max");
 
    }

    //revert if certain requirements aren't met

    //pay back current highest bidder
    // reset highest bidder highest bid; 
    //To transfer: add.transfer(value)

    function settle() public payable {
        require(getCurrentTime() >= end_time, "Auction time has ended");
        payable(max_bidder).transfer(maximum_bid);
        
    }

    //function to view max bid

    function getCurrentTime() public view returns(uint){
        return block.timestamp;
    }



}
