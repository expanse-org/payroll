pragma solidity ^0.4.23;

import "./Moderated.sol";

contract Payees is Moderated {

  event NewPayee(address index Payee, bool isEXP, bool isDepartment, bytes16 Name, uint Payrate);
  event RemovedPayee(address index Payee, bytes16 Name, address Admin);

  event SetModule(address index Module, bool Set);

  bytes16 public Department;

  address[] public payees;

  uint public totalEXPPay;
  uint public totalUSDPay;

  struct Payee {
    bool isDepartment;
    bool isActive;
    bool isEXP;
    uint payRate;
    bytes16 name;
    uint nextPay;
  }

  mapping(address => Payee) public mPayee;
  mapping(bytes32=>address) public names;
  mapping(address=>bool) public modules;

  constructor() public payable {
    root = msg.sender;
    addPayee(0x3fc964747ece2cfdc2e902f783205b15e9f8ae10, 10, true, "test", false);
  }

  /*---------------------- SETS ------------------------------*/

  function addPayee(address _e, uint _payRate, bool _isEXP, bytes16 _name, bool _isDepartment) public onlyRootOrAdmin returns(bool){

    for (uint i = 0; i < payees.length; i++){
      if(payees[i] == _e){revert("Already Exist in List");}
    }

    payees.push(_e);

    mPayee[_e].isActive = true;
    mPayee[_e].isDepartment = _isDepartment;
    mPayee[_e].isEXP = _isEXP;
    mPayee[_e].payRate = _payRate;
    mPayee[_e].name = _name;

    names[_name] = _e;

    if(_isEXP){
      totalEXPPay+=_payRate;
    }else{
      totalUSDPay+=_payRate;
    }

    emit NewPayee(_e, _isEXP, _isDepartment, _name, _payRate);

    return true;
  }

  function removePayee(address _e) public onlyRootOrAdmin returns(bool){
    uint index;
    bool exist;

    for (uint i = 0; i < payees.length; i++){
      if(payees[i] == _e){
        index = i;
        exist = true;
      }
    }

    if(exist){
      for (uint i2 = index; i<payees.length-1; i2++){
            payees[i2] = payees[i+1];
        }
        payees.length--;
    }

    if(mPayee[_e].isEXP){
      totalEXPPay-=mPayee[_e].payRate;
    }else{
      totalUSDPay-=mPayee[_e].payRate;
    }

    emit RemovedPayee(_e, mPayee[_e].name, msg.sender);
    setEmployee(_e, false, false, false, 0);
    return true;

  }

  function removeIndex(uint index) public onlyRootOrAdmin returns(address[]){
    if (index >= payees.length) revert();

        for (uint i = index; i<payees.length-1; i++){
            payees[i] = payees[i+1];
        }
        payees.length--;
        return payees;
  }

  function setPayee(address _e, bool _isActive, bool _isDepartment, bool _isEXP, uint _payRate) public onlyRootOrAdmin {
    mPayee[_e].isActive = _isActive;
    mPayee[_e].isDepartment = _isDepartment;
    mPayee[_e].isEXP = _isEXP;
    mPayee[_e].payRate = _payRate;
  }

  function setIsActive(address _e, bool _isActive) public onlyRootOrAdmin {
    mPayee[_e].isActive = _isActive;
  }

  function setIsDepartment(address _e, bool _isDepartment) public onlyRootOrAdmin {
    mPAyee[_e].isDepartment = _isDepartment;
  }

  function setIsEXP(address _e, bool _isEXP) public onlyRootOrAdmin {
    mPayee[_e].isEXP = _isEXP;
  }

  function setPayRate(address _e, uint _payRate) public onlyRootOrAdmin {
    mPayee[_e].payRate = _payRate;
  }

  function setNextPay(address _e, uint _nextPay) public onlyRootOrAdmin {
      mPayee[_e].nextPay = _nextPay;
  }

  function transferEmployeeAcct(address _oldAcct, address _newAccount) public onlyRootOrAdmin returns(bool){
    // register new user
    mPayee[_newAccount].nextPay = mPayee[_oldAcct].nextPay;
    mPayee[_newAccount].payRate = mPayee[_oldAcct].payRate; // stored in dollars with out any cents $1500
    mPayee[_newAccount].name = mPayee[_oldAcct].name;
    mPayee[_newAccount].isActive = mPayee[_oldAcct].isActive;
    mPayee[_newAccount].isEXP = mPayee[_oldAcct].isEXP;

    mPayee[_oldAcct].isActive = false;

    names[mPayee[_newAccount].name] = _newAccount;

    return true;
  }

  function setNewModule(address _m, bool _set) public onlyRootOrAdmin {
    modules[_m] = _set;
    emit SetModule(_m, _set);
  }

  function setDepartment(bytes16 _department) public onlyRootOrAdmin {
    Department = _department;
  }

  /*---------------------- GETS ------------------------------*/

  function lookupByName(bytes16 _name) public view returns(address){
    return names[_name];
  }

  function lookupArrayIndex(uint _index) public view returns(address) {
    return payees[index];
  }

  function getArrayLength() public view returns(uint) {
    return payees.length;
  }

  function getPayee(address _e) public view returns(bool isActive, bool isDepartment, bool isEXP, uint payRate, uint expBalance, bytes16 name, uint nextPayDate) {
    isActive = mPayee[_e].isActive;
    isDepartment = mPayee[_e].isDepartment;
    isEXP = mPayee[_e].isEXP;
    payRate = mPayee[_e].payRate;
    expBalance = balances[_e];
    name = mPayee[_e].name;
    nextPayDate = mPayee[_e].nextPay;
  }

  function getPayrate(address _e) public view returns(uint){
    return mPayee[_e].payRate;
  }

  function getIsEXP(address _e) public view returns(bool) {
    return mPayee[_e].isEXP;
  }


}
