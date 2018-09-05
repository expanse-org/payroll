pragma solidity ^0.4.23;

import "./PriceOracle.sol";
import "./Moderated.sol";

contract PayRoll is Moderated {
  event PayedEmployee(address indexed Employee, uint Rate);
  event Withdraws(address indexed Employee, uint Amount);

  PriceOracle public prices;

  uint public totalUSDPay;
  uint public totalEXPPay;
  uint public expHardCap;

  address[] public employees;


  struct Employee {
    bool isDepartment;
    bool isActive;
    bool isEXP;
    uint payRate;
    bytes16 name;
    uint nextPay;
  }

  mapping(address=>Employee) public emps;
  mapping(address=>uint) public balances;
  mapping(bytes32=>address) public names;

  constructor() public payable {
    root = msg.sender;
    prices = PriceOracle(0xb385fa580fc98c0291d40f3960bea4f36b404976);

    setAdmin(0x6a620a92Ec2D11a70428b45a795909bd28AedA45, true);
    addEmployee(0x3fc964747ece2cfdc2e902f783205b15e9f8ae10, 10, true, "test");
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
    for (uint i = 0; i < employees.length; i++){
      uint amount = balances[employees[i]];
      require(amount <= this.balance);
      balances[employees[i]] = 0;
      if(!employees[i].send(amount)){ revert();}

      emit Withdraws(employees[i], amount);
    }
  }

  function addEmployee(address _e, uint _payRate, bool _isEXP, bytes16 _name) public onlyRootOrAdmin returns(bool){

    for (uint i = 0; i < employees.length; i++){
      if(employees[i] == _e){revert("Already Exist in List");}
    }

    employees.push(_e);

    emps[_e].isActive = true;
    emps[_e].isEXP = _isEXP;
    emps[_e].payRate = _payRate;
    emps[_e].name = _name;

    names[_name] = _e;

    return true;
  }

  function removeEmployee(address _e) public onlyRootOrAdmin returns(bool){
    uint index;
    bool exist;

    for (uint i = 0; i < employees.length; i++){
      if(employees[i] == _e){
        index = i;
        exist = true;
      }
    }

    if(exist){
      for (uint i2 = index; i<employees.length-1; i2++){
            employees[i2] = employees[i+1];
        }
        employees.length--;
    }

    

    return true;

  }

  function removeIndex(uint index) public onlyRootOrAdmin returns(address[]){
    if (index >= employees.length) revert();

        for (uint i = index; i<employees.length-1; i++){
            employees[i] = employees[i+1];
        }
        employees.length--;
        return employees;
  }

  function calcTotalPay() public returns(uint, uint) {
    uint usdTotal;
    uint expTotal;

    for (uint i = 0; i < employees.length; i++){
        if(emps[employees[i]].isEXP){
            expTotal+=emps[employees[i]].payRate;
        }else{
            usdTotal+=emps[employees[i]].payRate;
        }

    }

    totalUSDPay = usdTotal;
    uint USD = totalUSDPay;

    totalEXPPay = calcEXP(totalUSDPay) + (expTotal * 1 ether);
    uint EXP = totalEXPPay;

    return (EXP, USD);

  }

  function getPrice() public view returns(uint) {
      return prices.getPrice();
  }

  function calcEXP(uint _n) public view returns(uint) {
    uint expPrice = (prices.getPrice() * 100) / 1 ether; // gives you usd price in pennies
    uint usdToWei = _n * 1 ether;
    uint pay = ((usdToWei * 100) / expPrice);

    if(pay > expHardCap){
      pay = expHardCap;
    }
    return pay;
  }

  function payEmployee(address _e) public onlyRootOrAdmin {
    uint amount;

    if(emps[_e].isActive && emps[_e].payRate > 0 && now > emps[_e].nextPay){
      if(emps[_e].isEXP){
        amount=emps[_e].payRate * 1 ether;
      }else{
        amount=calcEXP(emps[_e].payRate);
      }

      balances[_e]+=amount;
      emps[_e].nextPay = now + 15 days;

      emit PayedEmployee(_e, amount);
    }
  }

  /*
    This function tries to pay every employee in the employee array.
  */
  function payEmployees() public onlyRootOrAdmin {
    for (uint i = 0; i < employees.length; i++){
      payEmployee(employees[i]);
    }
  }

  function setEmployee(address _e, bool _isActive, bool _isEXP, uint _payRate) public onlyRootOrAdmin {
    emps[_e].isActive = _isActive;
    emps[_e].isEXP = _isEXP;
    emps[_e].payRate = _payRate;
  }

  function setIsActive(address _e, bool _isActive) public onlyRootOrAdmin {
    emps[_e].isActive = _isActive;
  }

  function setIsEXP(address _e, bool _isEXP) public onlyRootOrAdmin {
    emps[_e].isEXP = _isEXP;
  }

  function setPayRate(address _e, uint _payRate) public onlyRootOrAdmin {
    emps[_e].payRate = _payRate;
  }

  function setNextPay(address _e, uint _nextPay) public onlyRootOrAdmin {
      emps[_e].nextPay = _nextPay;
  }

  function getEmployee(address _e) public view returns(bool isActive, bool isEXP, uint payRate, uint expBalance, uint expPayRate, bytes16 name, uint nextPay) {
    isActive = emps[_e].isActive;
    isEXP = emps[_e].isEXP;
    payRate = emps[_e].payRate;
    expBalance = balances[_e];
    name = emps[_e].name;
    nextPay = emps[_e].nextPay;

    if(isEXP){
        expPayRate = payRate;
    }else{
        expPayRate = calcEXP(payRate);
    }
  }

  function transferEmployeeAcct(address _oldAcct, address _newAccount) public onlyRootOrAdmin returns(bool){
    // register new user
    emps[_newAccount].nextPay = emps[_oldAcct].nextPay;
    emps[_newAccount].payRate = emps[_oldAcct].payRate; // stored in dollars with out any cents $1500
    emps[_newAccount].name = emps[_oldAcct].name;
    emps[_newAccount].isActive = emps[_oldAcct].isActive;
    emps[_newAccount].isEXP = emps[_oldAcct].isEXP;

    emps[_oldAcct].isActive = false;

    names[emps[_newAccount].name] = _newAccount;

    return true;
  }

  function setPrices(address _prices) public onlyRootOrAdmin {

      prices = PriceOracle(_prices);

  }

  function setExpHardCap(uint _expHardCap) public onlyRootOrAdmin {
      expHardCap = _expHardCap * 1 ether;
  }

  function employeeLookUp(bytes16 _name) public view returns(address){
    return names[_name];
  }

}
