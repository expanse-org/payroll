pragma solidity ^0.4.8;
// Single Token
// price == price * 1 ether
contract PriceOracle {

  address public root;

  string public token;
  uint public price;
  uint public lastPrice;
  uint public lastUpdated;

  event Updated(address Admin, uint Price, uint LastPrice, uint LastUpdated);

  modifier onlyRoot(){
    if(root == msg.sender){ _ ;} else { revert(); }
  }

  modifier onlyAdmin(){
    if(root == msg.sender || admins[msg.sender] == true){ _ ;} else { revert(); }
  }

  mapping(address=>bool) public admins;

  function PriceOracle(uint _price){
    root = msg.sender;
    price = (_price * 1 ether) / 100;
    lastPrice = price;
  }

  function() public {
    revert();
  }

// maybe price should be the average of last price and this price?
  function getPrice() public returns(uint){
    return (price);
  }

  function getLastPrice() public returns(uint){
    return (lastPrice);
  }

  function getAvgPrice() public returns(uint){
    return ((price+lastPrice)/2);
  }
// Rate is a whole number that will be turned into a percent
// EX 8 == 0.08 == 8%
  function getConversion(uint _rate) public returns(uint){
    return( (price * 100) / _rate );
  }

//price will be sent in cents and convertd to wei
  function setPrice(uint _price) onlyAdmin() public returns(bool){
    lastPrice = price;
    price = (_price * 1 ether) / 100;
    lastUpdated = block.timestamp;
    //event
    Updated(msg.sender, _price, lastPrice, lastUpdated);
    //return
    return true;
  }

  function setAdmin(address _admin, bool _set) public onlyRoot() returns(bool){
    admins[_admin] = _set;
    return true;
  }
}
