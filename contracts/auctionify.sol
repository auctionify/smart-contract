pragma solidity ^0.4.22;

contract Auctionify {
    // Parameters of the auction.
    // Time is absolute unix timestamps

    address public beneficiary;
    uint public auctionEnd;
    string public auctionTitle;
    string public auctionDescription;
    uint public minimumBid;

    // Current state of the auction.
    address public highestBidder;

    // List of all the bids
    mapping(address => uint) public bids;

    // State of the Auction
    enum AuctionStates { Started, Ongoing, Ended }
    AuctionStates public auctionState;


    //modifiers
    modifier auctionNotEnded()
    {
        // Revert the call if the bidding
        // period is over.
        require(
            now < auctionEnd, // do not front-run me miners
            "Auction already ended."
        );
        require(
          auctionState != AuctionStates.Ended,
           "Auction already ended."
          );
        _;
    }

    //modifiers
    modifier isMinimumBid()
    {
      // If the bid is higher than minimumBid
      require(
          msg.value >= minimumBid,
          "The value is smaller than minimum bid."
      );
      _;
    }

    modifier isHighestBid()
    {
      // If the bid is not higher, send the
      // money back.
      require(
          msg.value > bids[highestBidder],
          "There already is a higher bid."
      );
      _;
    }

    // Events that will be fired on changes.
    event HighestBidIncreased(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);

    constructor(
        string _auctionTitle,
        uint _auctionEnd,
        address _beneficiary,
        string _auctionDesc,
        uint _minimumBid
    ) public {
        auctionTitle = _auctionTitle;
        beneficiary = _beneficiary;
        auctionEnd = _auctionEnd;
        auctionDescription = _auctionDesc;
        auctionState = AuctionStates.Started;
        minimumBid = _minimumBid;
    }

    /// Bid on the auction with the value sent
    /// together with this transaction.
    /// The lesser value will be refunded
    function bid() public payable auctionNotEnded isMinimumBid isHighestBid {
        // No arguments are necessary, all
        // information is already part of
        // the transaction.
        if (highestBidder != 0) {
            //refund the last highest bid
            uint lastBid = bids[highestBidder];
            bids[highestBidder] = 0;
            highestBidder.transfer(lastBid);
        }

        //set the new highestBidder
        highestBidder = msg.sender;
        bids[msg.sender] = msg.value;

        emit HighestBidIncreased(msg.sender, msg.value);
    }

    // returns the highest bid value
    function highestBid() public view returns(uint){
      return bids[highestBidder]
    }

    /// End the auction and send the highest bid
    /// to the beneficiary.
    function endAuction() public {

        // 1. Conditions
        require(now >= auctionEnd, "Auction not yet ended.");
        require(auctionState != AuctionStates.Ended, "Auction has already ended.");

        // 2. Effects
        auctionState = AuctionStates.Ended;
        emit AuctionEnded(highestBidder, bids[highestBidder]);

        // 3. Interaction. send the money to the beneficiary
        beneficiary.transfer(bids[highestBidder]);
    }

  function cleanUpAfterYourself() public {
    require(auctionState == AuctionStates.Ended, "Auction is not ended.");
 //   if (address(this).balance == 0){ //should be 0 but not limiting just in case!
      selfdestruct(beneficiary); //save blockchain space, save lives
 //   }
  }
}
