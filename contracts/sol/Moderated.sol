pragma solidity ^0.4.23;

contract Moderated {
  address public root;

  mapping(address=>bool) public admins;

  modifier onlyRoot(){
    if(root == msg.sender){ _ ;} else { revert(); }
  }

  modifier onlyRootOrAdmin(){
    if(root == msg.sender || admins[msg.sender] == true){ _ ;} else { revert(); }
  }

  function setAdmin(address _acct, bool _set) public onlyRoot {
    admins[_acct] = _set;
  }

  function empty(address _sendTo) public onlyRoot { if(!_sendTo.send(address(this).balance)) revert(); }
  function kill() public onlyRoot { selfdestruct(root); }
  function transferRoot(address _newOwner) public onlyRoot { root = _newOwner; }

}
