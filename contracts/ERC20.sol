// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ERC20 {
    uint256 public totalSupply;

    mapping(address => uint256) public balanceOf;

    mapping(address => mapping(address => uint256)) public allowance;
    string public name = "AvalNet";
    string public symbol = "AVN";
    uint8 public decimals = 18;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    function transfer(address recipient, uint256 amount) external returns (bool) {
    require(balanceOf[tx.origin] >= amount, "Insufficient balance"); 
    balanceOf[tx.origin] -= amount; 
    balanceOf[recipient] += amount; 
    emit Transfer(tx.origin, recipient, amount);
    return true;
}


    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(address _user, uint256 amount) external {
        balanceOf[_user] += amount;
        totalSupply += amount;
        emit Transfer(address(0), _user, amount);
    }

    function burn(uint256 amount) external {
        require(balanceOf[tx.origin] >= amount, "insufficient balance");
        balanceOf[tx.origin] -= amount;
        totalSupply -= amount;
        emit Transfer(tx.origin, address(0), amount);
    }
}
