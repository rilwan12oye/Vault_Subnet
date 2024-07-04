# Vault Exchange
Vault Exchange is a simple saving contract written in Solidity and deployed on a custom subnet on Avalanche Network.

## Description
The Vault Exchange is a saving contract that takes ethers from the user, converts it to the contract ERC-20 token worth, and saves it in the contract. The user can transfer the token within the contract, the user can also withdraw the ether equivalent of the token.

The contract has 6 user-defined functions:

- depositAndSave(): Allows the user to send ethers with the message. This function converts user ether to the ERC-20 token, usually 1 wei to 5 of the contract token.
- userBalance(address _user): Allows user to check their ERC-20 balance
- tokenWorth(address _user): Only the owner can call this function and the owner uses this function to know the ERC-20 token worth of the user Ether before funding the user account with the token.
- fundUser(address _user): Having gotten the user token worth, the owner uses this function to fund the user account with the token equivalent.
- userTransferToken(address _otherUser, uint256 _value): Allows user to transfer token to another user.
- userWithdraws(uint256 _value): Allows user to withdraw ether equivalent of their token.

## Getting Started
```git clone https://github.com/devfola/Meta-Degen.git``` to clone the project. 
After cloning the GitHub, do the following to get the code running on your computer.

- visit ```https://docs.avax.network/tooling/cli-guides/install-avalanche-cli``` to install avalanche CLI on your computer
- When the CLI is installed, type ```avalanche subnet create mySubnet```. Instead of the mySubnet, you can choose your own subnet name.
- To configure your subnet, reply your terminal with the following answers as the query comes ```avalanche subnet create mySubnet
Attempted to check if a new version is available, but couldn't find the currently running version information
Make sure to follow official instructions or automatic updates won't be available for you
✔ Subnet-EVM
creating subnet mySubnet
Enter your subnet's ChainId. It can be any positive integer.
ChainId: 12345567
Select a symbol for your subnet's native token
Token symbol: MYSUBNET
✔ Use latest version
✔ Low disk use    / Low Throughput    1.5 mil gas/s (C-Chain's setting)
✔ Airdrop 1 million tokens to the default address (do not use in production)
✔ No```
- To deploy your subnet, type ```avalanche subnet deploy mySubnet```
- When your subnet is ready, you should see your subnet information and it will look like this but not exactly this: ```Browser Extension connection details (any node URL from above works):
RPC URL:          http://127.0.0.1:9650/ext/bc/SPqou41AALqxDquEycNYuTJmRvZYbfoV9DYApDJVXKXuwVFPz/rpc
Funded address:   0x8db97C7cEcE249c2b98bDC0226Cc4C2A57BF52FC with 1000000 (10^18) - private key: 56289e99c94b6912bfc12adc093c9b51124f0dc54ac7a766b2bc5ccf558d8027
Network name:     mySubnet
Chain ID:         54325
Currency Symbol:  TUTORIAL```. Use this information to set up a network on Metamask
- With all of these, you should be able to interact with the contract.
- When you are done with everything, including interacting with the contract, type  ```avalanche network stop ``` to shut the subnet down.

## Authors
Warith Adebowale

## License
This project is licensed under the MIT License - see the LICENSE.md file for details
