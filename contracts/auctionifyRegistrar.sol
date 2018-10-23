pragma solidity ^0.4.22;

contract AuctionifyRegistrar {

    address public owner;

    // List of all the auctions
    mapping(uint => address) public auctions;

    constructor() public {
      owner = msg.sender;
    }

    event AuctionAdded(address indexed auctionAddress);


    function addAuction(address _auctionAddress) public {
        // list auctions
        auctions.push(_auctionAddress);
        emit AuctionAdded(address indexed auctionAddress);
        }


  
}
