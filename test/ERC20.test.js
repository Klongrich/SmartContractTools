const ERC20 = artifacts.require('ERC20')

const { expect } = require('chai')

let owner
let userOne
let userTwo
let kyleCoin

// function name() public view returns (string)
// function symbol() public view returns (string)
// function decimals() public view returns (uint8)
// function totalSupply() public view returns (uint256)

// function balanceOf(address _owner) a view returns (uint256 balance)
// function transfer(address _to, uint256 _value) public returns (bool success)
// function transferFrom(address _from, address _to, uint256 _value) public returns (bool success)

// function approve(address _spender, uint256 _value) public returns (bool success)
// function allowance(address _owner, address _spender) public view returns (uint256 remaining)

// event Transfer(address indexed _from, address indexed _to, uint256 _value)
// event Approval(address indexed _owner, address indexed _spender, uint256 _value)

// string memory _name,
// string memory _symbol,
// uint8 _decimals,
// uint256 _totalSupply

describe('Test Coin', () => {
    before(async () => {
        accounts = await web3.eth.getAccounts()

        owner = accounts[0]
        userOne = accounts[1]
        userTwo = accounts[2]
    })

    it("Deploys the Contract", async () => {
        kyleCoin = await ERC20.new("KyleCoin", "KC", 18, 71400000000)
        console.log("name: " + await kyleCoin.name())
        console.log("symbol: " + await kyleCoin.symbol())
        console.log("decimals: " + await kyleCoin.decimals())
        console.log("totalSupply: " + await kyleCoin.totalSupply());

        expect(kyleCoin.address).not.to.be.null
    })

    it("Mint Coins", async () => {
        let res;

        await kyleCoin.mint(owner, 10000);
        res = await kyleCoin.balanceOf(owner);

        console.log(res);
    })

    it("Transfers Coins", async () => {
        await kyleCoin.transfer(userOne, 714);
        await kyleCoin.transfer(userTwo, 714);

        console.log("Owner Balance: " + await kyleCoin.balanceOf(owner));
        console.log("Userone Balance: " + await kyleCoin.balanceOf(userOne));
        console.log("Usertwo Balance: " + await kyleCoin.balanceOf(userTwo));
    })

    it("Approves Transfer Of Coints", async () => {
        await kyleCoin.approve(userOne, 7140);
    })

    it("Transfers From Coins", async () => {
        await kyleCoin.transferFrom(owner, userOne, 714)
    })
})
