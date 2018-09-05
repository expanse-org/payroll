pragma solidity ^0.4.23;

import "./PriceOracle.sol";
import "./Moderated.sol";
import "./Payees.sol";

contract PayRoll is Moderated {
  event PayedEmployee(address indexed Employee, uint Rate);
  event Withdraws(address indexed Employee, uint Amount);

  PriceOracle public Prices;
  Payees public Pay;

  uint public expHardCap;

  mapping(address=>uint) public balances;


  constructor(address _pricesContract, address _payeesContract) public payable {
    root = msg.sender;
    //0xb385fa580fc98c0291d40f3960bea4f36b404976
    Prices = PriceOracle(_pricesContract);
    Pay = Payees(_payeesContract);

    setAdmin(0x6a620a92Ec2D11a70428b45a795909bd28AedA45, true);
    setExpHardCap(5000);

  }

  function () public payable {

  }

  function withdraw() public {
      uint amount = balances[msg.sender];
      //if(this.balance <= bal){ revert("balance isnt enough");}
      require(amount <= this.balance);
      balances[msg.sender]=0;
      if(!msg.sender.send(amount)){ revert("send failed");}

      emit Withdraws(msg.sender, amount);
  }

  function forceWithdraw(address _e) public onlyRootOrAdmin {

      uint amount = balances[_e];
      require(amount <= this.balance);
      balances[_e] = 0;
      if(!_e.send(amount)){ revert();}

      emit Withdraws(_e, amount);

  }

  function forceWithdrawAll() public onlyRootOrAdmin {
    for (uint i = 0; i < payees.length; i++){
      uint amount = balances[payees[i]];
      require(amount <= this.balance);
      balances[payees[i]] = 0;
      if(!payees[i].send(amount)){ revert();}

      emit Withdraws(payees[i], amount);
    }
  }

  function calcEXP(uint _n) public view returns(uint) {
    uint expPrice = (Prices.getPrice() * 100) / 1 ether; // gives you usd price in pennies
    uint usdToWei = _n * 1 ether;
    uint pay = ((usdToWei * 100) / expPrice);

    if(pay > expHardCap){
      pay = expHardCap;
    }
    return pay;
  }

  function payPayee(address _e) public onlyRootOrAdmin {
    uint amount;

    var(isActive, isDepartment, isEXP, payRate, expBalance, name, nextPayDate) = Pay.getPayee(_e);

    if(isActive && payRate > 0 && now > nextPay){
      if(isEXP){
        amount=payRate * 1 ether;
      }else{
        amount=calcEXP(payRate);
      }

      balances[_e]+=amount;
      Pay.setNextPay(now + 15 days);
      emit PayedEmployee(_e, amount);
    }
  }

  /*
    This function tries to pay every employee in the employee array.
  */
  function payPayees() public onlyRootOrAdmin {
    for (uint i = 0; i < Pay.getArrayLength(); i++){
      payPayee(Pay.lookupArrayIndex(i));
    }
  }


/*---------------------- SETS ------------------------------*/

  function setPrices(address _Prices) public onlyRootOrAdmin {
      Prices = PriceOracle(_Prices);
  }

  function setExpHardCap(uint _expHardCap) public onlyRootOrAdmin {
      expHardCap = _expHardCap * 1 ether;
  }

  function getExpPrice() public view returns(uint) {
      return Prices.getPrice();
  }




}
