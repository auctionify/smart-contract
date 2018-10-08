# Auctionify Smart Contract

`auctionify.sol` is the solidity code for Auctionify and is responsible for the core functionality on Ethereum blockchain.


## Deployment:
The constructor function requires the following inputs:
```
string _auctionTitle,
uint _auctionEnd, //timestamp of the end time in which bids will not be accepted
address _beneficiary, //where the highestBid funds will be transferred to
string _auctionDesc,
uint _minimumBid //Minimum bid that is accepted in Wei
```

## Bidding
`bid()` will accept bids (higher than `minimumBid`) from the deployment `auctionStart` to `auctionEnd`.
On receiving the higher bid, it will refund the second high bid. Only the highest bidder funds will be kept in the auctionify address.


## End Auction
`endAuction()` : Only callable after `auctionEnd`. This function will transfer the `HighestBid` to the `beneficiary`.


## Clean up
`cleanUpAfterYourself()` can be called after the end of the auction to self destruct the contract


## Read contract:
```
// Auction details
auctionTitle()
auctionDescription()
beneficiary()
auctionEnd() //timestamp of the auction end
minimumBid() //in Wei

// Highest bid details
highestBidder()
highestBid()
```

## Events
```
event HighestBidIncreased(address bidder, uint amount);
event AuctionEnded(address winner, uint amount);
event CheaterBidder(address cheater, uint amount);
```


# TODO:
- Escrow option with `auctionify.eth` being the escrow
  - ENS resolver for .eth to address (?)
  - Fee structure for Escrow
  - Github issue template for disputes
- Auction registry smart contract
  - opt out option (unlisted)
- Verify highestBidder page
  - Sign contact for Highest bidder(email/phone)
  - Verify page for Beneficiary (URL)
- Mobile wallets support (Trust Wallet, Coinbase Wallet)
- Update smart contract on UI deploy (pipeline)
- 
