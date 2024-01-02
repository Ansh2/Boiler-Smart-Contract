// SPDX-License-Identifier: MIT
//pragma solidity ^0.8.6;

pragma solidity ^0.8.8; 
//prgram solidity >=0.8.0 <0.9.0;



contract SimpleStorage {
    string public myString = "Hello"; 
    int256 a; 
    bool b; 
    uint d;
    address e = 0x2062CbFF84a9D0BC6157fE3709340F63aFcC06a4;
    bytes1 f; //the maximum amount you can store is bytes32


    uint256 public favoriteNumber = 15; //getter function automatically defined

    //very impotant function
    

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    function add(int x, int y) public pure returns (int256) {
        return x+y; 
    }

    //repetitive

    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

    struct People { //scope within this
        uint256 favoriteNumber;
        string name;
    }

    People p = People(19, "Soham"); 
    
    People[] public people; 
    mapping(string => uint256 ) public nameToFavoriteNumber;

    function addPerson(string memory _name, uint _favoriteNumber) public {
        _name="jack";
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }



    // function buyTokens() payable {
    //     uint tokens = msg.value / tokenPrice;
    //     balance[msg.sender] += tokens; 
    // }

    // function getBalance(address _address) view returns
    // (uint) {
    //     return balance[_address]; 
    // }

    // function set(uint8 value) public {

    // }

    //data s stored in Solidity

    struct Apple {
        uint256 id;
        address owner;
        uint256 data;
    }

    mapping (uint256 => Apple) apples;

    function sendApple(uint256 id, uint data) public {
        require(msg.sender == apples[id].owner);
        apples[id].data = data;
    }

    function hellosir(uint256) public {
        uint256 hello = 1;
    }

    function createApple(uint256 id) public {
        require(apples[id].owner == address(0));
        apples[id] = Apple(id, msg.sender, 0);
    }

    modifier onlyValid(uint256 id, uint256 data) {
        _; //checks everything at start and everything at end depending on the placement of this part
        require(data%2 ==0); //data should be even
        require(msg.sender == apples[id].owner);

    }

}
