# FundMe

This project contains a smart contract for a decentralized crowdfunding platform built with Solidity and the Foundry framework.

## Description

The `FundMe` smart contract allows users to fund a project with ETH. The contract uses Chainlink price feeds to ensure that the value of the contributed ETH is above a certain minimum USD threshold. The owner of the contract has the ability to withdraw the collected funds.

This project serves as an educational example of how to build, test, and deploy a smart contract using modern Ethereum development tools.

## Getting Started

### Prerequisites

- [Foundry](https://getfoundry.sh/): A blazing fast, portable and modular toolkit for Ethereum application development written in Rust.

### Installation

1. Clone the repository:
   ```shell
   git clone https://github.com/Sudhanshugupta26/Fund-Me
   cd Fund-Me
   ```

2. Install dependencies:
   This project uses git submodules for dependencies.
   ```shell
   forge install
   ```
   Or
    ```shell
    git submodule update --init --recursive
    ```


### Configuration

Create a `.env` file in the root directory and add the following environment variables. You will need these for deploying to a testnet or mainnet.

```
SEPOLIA_RPC_URL=<your_sepolia_rpc_url>
PRIVATE_KEY=<your_private_key>
ETHERSCAN_API_KEY=<your_etherscan_api_key>
```

## Usage

### Build

To build the project, run:
```shell
forge build
```

### Test

To run the tests, run:
```shell
forge test
```
To run tests with more verbosity:
```shell
forge test -vvv
```

### Deploy

To deploy the `FundMe` contract to a network, use the following command. Make sure to have your `.env` file configured.

```shell
forge script script/DeployFundMe.s.sol --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast --verify
```

### Interacting with the Contract

After deployment, you can interact with the contract using `cast` or by writing scripts.

**Funding the contract:**
```shell
cast send <CONTRACT_ADDRESS> "fund()" --value <AMOUNT_IN_ETH> --private-key $PRIVATE_KEY
```

**Withdrawing funds (as owner):**
```shell
cast send <CONTRACT_ADDRESS> "withdraw()" --private-key $PRIVATE_KEY
```

## Contract Details

The main contract in this project is `FundMe.sol`.

### Key Functions

- `fund()`: Allows any user to send ETH to the contract. It checks if the amount sent is greater than or equal to `MINIMUM_USD`.
- `withdraw()`: Allows the owner of the contract to withdraw all the funds.
- `cheaperWithdraw()`: A more gas-efficient version of the `withdraw` function.

### Price Feeds

The contract uses [Chainlink Price Feeds](https://docs.chain.link/data-feeds/price-feeds/addresses) to get the latest ETH/USD price. This is used to ensure that the funded amount meets the minimum requirement in USD. The `PriceConverter.sol` library handles the logic for price conversion.

## Testing

The project includes a comprehensive test suite in `test/unit/FundMeTest.t.sol`. The tests cover:
- Ownership and access control.
- Funding and withdrawal logic.
- Price feed integration.
- Correct state updates after funding and withdrawal.
