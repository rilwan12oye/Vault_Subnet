// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


interface IERC20 {
    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function mint(address _user, uint256 amount) external;

    function burn(uint256 amount) external;
}



contract VaultExchange {
    IERC20 private immutable token;
    address private  immutable admin;

    uint256 private  constant XRATE = 5;

    mapping(address => uint256) private userWorth;

    event UserDeposited(
        address indexed user,
        uint256 indexed eth,
        uint256 indexed token
    );
    event UserFunded(address indexed user, uint256 indexed token);

    event Withdrawal(address user, uint256 _value);

    constructor(address _token) {
        token = IERC20(_token);
        admin = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == admin, "ONLY OWNER");
        _;
    }

    modifier enoughBal(uint256 _value) {
        require(
            token.balanceOf(msg.sender) > 0 &&
                token.balanceOf(msg.sender) >= _value,
            "Insufficient Balance"
        );
        _;
    }

    function userBalance(address _user) external view returns (uint256) {
        return token.balanceOf(_user);
    }

    function depositAndSave() external payable {
        require(XRATE > 0, "Set exchange rate");
        uint256 _value = msg.value;
        require(_value > 0, "Cannot deposit zero value");

        uint256 _tokenValue = _value * XRATE;

        userWorth[msg.sender] = _tokenValue;
        emit UserDeposited(msg.sender, msg.value, _tokenValue);
    }

    function tokenWorth(address _user)
        external
        view
        onlyOwner
        returns (uint256)
    {
        return userWorth[_user];
    }

    function fundUser(address _user) external onlyOwner {
        require(userWorth[_user] > 0, "No deposit");
        uint256 _value = userWorth[_user];

        delete userWorth[_user];

        token.mint(_user, _value);

        emit UserFunded(_user, _value);
    }

    function userTransferToken(address _otherUser, uint256 _value) external enoughBal(_value){
        require(_otherUser != address(0), "Not allowed");

        require(token.transfer(_otherUser, _value), "Transfer failed");
    }

    function userWithdraws(uint256 _value) external enoughBal(_value) {
        require(address(this).balance >= _value, "You cannot withdraw now");

        token.burn(_value);

        uint256 _eth = _value / XRATE;

        payable(msg.sender).transfer(_eth);

        emit Withdrawal(msg.sender, _eth);
    }
}