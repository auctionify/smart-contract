pragma solidity ^0.4.22;

contract Auctionify {

    address public owner;

    // List of all the auctions
    mapping(uint => address) public auctions;


    constructor() public {
      owner = msg.sender;
    }

    event AuctionAdded(address indexed auctionAddress);


    function list(address _auctionAddress) public {
        // list auctions
        auctions.push(_auctionAddress);
        emit AuctionAdded(address indexed auctionAddress);
        }

        //set the new highestBidder
        highestBidder = msg.sender;
        bids[msg.sender] = msg.value;

        emit HighestBidIncreased(msg.sender, msg.value);
    }

    // returns the highest bid value
    function highestBid() public view returns(uint){
      return (bids[highestBidder]);
    }

    /// End the auction and send the highest bid
    /// to the beneficiary.
    function endAuction() public onlyHighestBidderOrEscrow {

        // 1. Conditions
        require(now >= auctionEnd, "Auction not yet ended.");
        require(auctionState != AuctionStates.Ended, "Auction has already ended.");

        // 2. Effects
        auctionState = AuctionStates.Ended;
        emit AuctionEnded(highestBidder, bids[highestBidder]);

        // 3. Interaction. send the money to the beneficiary
        if(!beneficiary.send(bids[highestBidder])) {
            // if failed to send, the final bid is kept in the contract
            // the funds can be released using cleanUpAfterYourself()
        }
    }

  function cleanUpAfterYourself() public {
    require(auctionState == AuctionStates.Ended, "Auction is not ended.");
      selfdestruct(beneficiary); //save blockchain space, save lives
  }
}
