// SPDX-License-Identifier: MIT
pragma solidity =0.8.3;

import "./Interfaces/IERC20.sol";

contract ERC20 is IERC20 {
    mapping(address => uint256) public override balanceOf;

    mapping(address => mapping(address => uint256)) public override allowance;

    string public override name;
    string public override symbol;
    uint8 public override decimals;
    uint256 public override totalSupply;

    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _totalSupply) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
    }

    function mint(address _to, uint256 _amount) external returns (bool) {
        require(totalSupply - _amount >= 0, "Minting Over Total Supply");

        balanceOf[_to] += _amount;
        totalSupply -= _amount;

        emit Transfer(address(0), _to, _amount);
        return (true);

    }
    function approve(address _spender, uint256 _value) external override returns (bool) {
        require(_spender != address(0), "Address is Null");
        require(balanceOf[msg.sender] >= _value, "Insuffectin Funds / Coins");

        allowance[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);
        return (true);
    }

    function transfer(address _to, uint256 _value) external override returns (bool) {
        require(balanceOf[msg.sender] >= _value, "Insuffectin Funds / Coins");

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
        return (true);
    }

    function transferFrom(address _from, address _to, uint256 _value ) external override returns (bool) {
        require(_value <= allowance[_from][_to], "Transaction is not Approved");

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(_from, _to, _value);
        return (true);
    }
}
