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



}
