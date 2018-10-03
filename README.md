# Auctionify Smart Contract

`auctionify.sol` is the solidity code for Auctionify and is responsible for the core functionality on Ethereum blockchain.


## Deployment:
The constructor function requires the following inputs:
```
string _auctionTitle,
uint _auctionEnd, //timestamp of the end time in which bids will not be accepted
address _beneficiary, //where the highestBid funds will be transferred to
string _auctionDesc,
uint _minimumBid //Minimum bid that is accepted
```

## Bidding
The smart contract `bid()` will accept bids (higher than `minimumBid`) from the deployment to `auctionEnd`.
On receiving the higher bid, it will refund the second high bid. Only the highest bidder funds will be kept in the auctionify address.


## End Auction
Only callable after `auctionEnd`. This function will transfer the `HighestBid` to the `beneficiary`.


## Clean up
`cleanUpAfterYourself()` can be called after the end of the auction to self destruct the contract


## Read contract:
```
auctionTitle
auctionDescription
beneficiary
auctionEnd
minimumBid

highestBidder()
highestBid()
```

## Events
```
event HighestBidIncreased(address bidder, uint amount);
event AuctionEnded(address winner, uint amount);
event CheaterBidder(address cheater, uint amount);
```
