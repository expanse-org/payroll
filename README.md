# PAYROLL dapp
PAY ROLL DAPP

## Price Oracle Address
`0xb385fa580fc98c0291d40f3960bea4f36b404976`

## Payroll Oracle Address
`0xed201029d05de2b63fed87b8d9254ddc9e4e5159`

# Payroll Contract ABI

```
[
	{
		"constant": true,
		"inputs": [],
		"name": "prices",
		"outputs": [
			{
				"name": "",
				"type": "address"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "address"
			}
		],
		"name": "balances",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "_n",
				"type": "uint256"
			}
		],
		"name": "calcEXP",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "_name",
				"type": "bytes16"
			}
		],
		"name": "employeeLookUp",
		"outputs": [
			{
				"name": "",
				"type": "address"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "totalEXPPay",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "address"
			}
		],
		"name": "emps",
		"outputs": [
			{
				"name": "isActive",
				"type": "bool"
			},
			{
				"name": "isEXP",
				"type": "bool"
			},
			{
				"name": "payRate",
				"type": "uint256"
			},
			{
				"name": "name",
				"type": "bytes16"
			},
			{
				"name": "nextPay",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "expHardCap",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "_e",
				"type": "address"
			}
		],
		"name": "getEmployee",
		"outputs": [
			{
				"name": "isActive",
				"type": "bool"
			},
			{
				"name": "isEXP",
				"type": "bool"
			},
			{
				"name": "payRate",
				"type": "uint256"
			},
			{
				"name": "expBalance",
				"type": "uint256"
			},
			{
				"name": "expPayRate",
				"type": "uint256"
			},
			{
				"name": "name",
				"type": "bytes16"
			},
			{
				"name": "nextPay",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "getPrice",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "root",
		"outputs": [
			{
				"name": "",
				"type": "address"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "totalUSDPay",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "bytes32"
			}
		],
		"name": "names",
		"outputs": [
			{
				"name": "",
				"type": "address"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "address"
			}
		],
		"name": "admins",
		"outputs": [
			{
				"name": "",
				"type": "bool"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"name": "employees",
		"outputs": [
			{
				"name": "",
				"type": "address"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_e",
				"type": "address"
			}
		],
		"name": "payEmployee",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"name": "Employee",
				"type": "address"
			},
			{
				"indexed": false,
				"name": "Rate",
				"type": "uint256"
			}
		],
		"name": "PayedEmployee",
		"type": "event"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_e",
				"type": "address"
			},
			{
				"name": "_isActive",
				"type": "bool"
			}
		],
		"name": "setIsActive",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [],
		"name": "withdraw",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_e",
				"type": "address"
			},
			{
				"name": "_isEXP",
				"type": "bool"
			}
		],
		"name": "setIsEXP",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_e",
				"type": "address"
			}
		],
		"name": "removeEmployee",
		"outputs": [
			{
				"name": "",
				"type": "bool"
			}
		],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_e",
				"type": "address"
			},
			{
				"name": "_nextPay",
				"type": "uint256"
			}
		],
		"name": "setNextPay",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_newOwner",
				"type": "address"
			}
		],
		"name": "transferRoot",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [],
		"name": "calcTotalPay",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			},
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [],
		"name": "kill",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"payable": true,
		"stateMutability": "payable",
		"type": "fallback"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_e",
				"type": "address"
			},
			{
				"name": "_isActive",
				"type": "bool"
			},
			{
				"name": "_isEXP",
				"type": "bool"
			},
			{
				"name": "_payRate",
				"type": "uint256"
			}
		],
		"name": "setEmployee",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"payable": true,
		"stateMutability": "payable",
		"type": "constructor"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_expHardCap",
				"type": "uint256"
			}
		],
		"name": "setExpHardCap",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [],
		"name": "payEmployees",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_e",
				"type": "address"
			},
			{
				"name": "_payRate",
				"type": "uint256"
			},
			{
				"name": "_isEXP",
				"type": "bool"
			},
			{
				"name": "_name",
				"type": "bytes16"
			}
		],
		"name": "addEmployee",
		"outputs": [
			{
				"name": "",
				"type": "bool"
			}
		],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_oldAcct",
				"type": "address"
			},
			{
				"name": "_newAccount",
				"type": "address"
			}
		],
		"name": "transferEmployeeAcct",
		"outputs": [
			{
				"name": "",
				"type": "bool"
			}
		],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_prices",
				"type": "address"
			}
		],
		"name": "setPrices",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_e",
				"type": "address"
			},
			{
				"name": "_payRate",
				"type": "uint256"
			}
		],
		"name": "setPayRate",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "index",
				"type": "uint256"
			}
		],
		"name": "removeIndex",
		"outputs": [
			{
				"name": "",
				"type": "address[]"
			}
		],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_sendTo",
				"type": "address"
			}
		],
		"name": "empty",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [],
		"name": "forceWithdrawAll",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_acct",
				"type": "address"
			},
			{
				"name": "_set",
				"type": "bool"
			}
		],
		"name": "setAdmin",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	}
]

```

# How To Setup Payroll Contracts
- [ ] Launch payroll contract with price oracle
- [ ] setEXPHardCap
- [ ] Add employees
- [ ] calcTotal
- [ ] Send EXP to contract equivalent to the return of the “totalEXPPay” call

# How To Pay Employees
- [ ] Click calcTotal
- [ ] Update expanse price using price oracle (expPrice * 100)
- [ ] Divide totalUSDPay by getPrice
- [ ] Send exp to contract
- [ ] Click “pay employees”
- [ ] Employees can then withdraw their funds at will

# How To Setup Payroll With MEW
- [ ] Go to myetherwallet.com
- [ ] Go to contracts tab
- [ ] Copy and paste payroll oracle contract address
- [ ] Copy and paste payroll abi json
- [ ] Click access
- [ ] Load your address up
- [ ] Select “withdraw” from drop down menu

### Notes
Make sure to use the address you supplied me to withdraw your funds.

# How to Setup Payroll with Mist / Luna
- [ ] Open mist
- [ ] Go to contracts tab
- [ ] Click “watch contract”
- [ ] Copy and paste payroll contract address into address field
- [ ] Copy and paste payroll contract abi into abi field
- [ ] type “Payroll” into name field
- [ ] Click ok
- [ ] Click “Payroll” on contracts tab
- [ ] On the right side select “withdraw” from “pick a function” dropdown menu
- [ ] Select your address from “execute from” drop down menu

### Notes
Make sure to use the address you supplied me to withdraw your funds.
