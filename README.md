# PAYROLL dapp
PAY ROLL DAPP

## Price Oracle Address
`0xb385fa580fc98c0291d40f3960bea4f36b404976`

## Payroll Oracle Address
`0xed201029d05de2b63fed87b8d9254ddc9e4e5159`

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
