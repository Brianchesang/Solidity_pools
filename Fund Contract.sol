// SPDX-License-Identifier: MIT
 pragma solidity >=0.6.0<=0.9.0;
 import"@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

 contract fund_contract{
     mapping(address=>uint256) addressToAmountFunded;

     address  [] public  poolMembers;
     uint256  public totalPoolValue = 0 ; 

    
    function getEthPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 answer,,,)  = priceFeed.latestRoundData();
        return uint256(answer) ;
    }

    function getEthUsdConversionRAte(uint256 ethAmount) public view returns(uint256){
        uint256 ethPrice = getEthPrice();
        uint256 ethAmountInUSD = (ethAmount * ethPrice )/100000000;
        return ethAmountInUSD;
    }

    function fund() public payable{
        uint256 minimumFund = 10;
        require(getEthUsdConversionRAte(msg.value)>=minimumFund);
        addressToAmountFunded[msg.sender] += msg.value;
        totalPoolValue = totalPoolValue + msg.value;
        poolMembers.push(msg.sender);





    }





    
     
 }

