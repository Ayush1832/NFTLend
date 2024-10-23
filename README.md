# NFTLend



## Introduction

The NFTLend is a decentralized application (dApp) designed to facilitate peer-to-peer lending using NFTs (ERC721 tokens) as collateral. Borrowers can stake their NFTs to request loans, while lenders can fund these loan requests, earning interest over time. The platform ensures secure transactions by locking the NFTs as collateral until the loan is repaid or defaulted, at which point the lender can claim the NFT. Built on Polygon, it leverages smart contracts for managing collateral, loan funding, repayment, and liquidation, providing transparency and automation in decentralized finance (DeFi).

## Problem It Solves
- **Problem 1-** 
**NFT Liquidity Issues and Idle Capital**
Traditionally, NFT holders face liquidity issues with their assets, while individuals with idle capital lack opportunities for substantial returns.

**Solution-** 
We introduce NFTLend, a transparent, secure, and user-friendly ecosystem that facilitates instant NFT-backed loans, effectively solving the challenge.

- **Problem 2-** 
**Trust Issues and Security Concerns**
Participants in the NFT market often grapple with trust issues. Additionally, concerns about theft or loss from server shutdowns or project discontinuations persist.

**Solution-** 
We utilize the Polygon blockchain and smart contracts, ensuring a secure lending process while eliminating the risk of theft or loss, as NFTs are securely held in the blockchain.


## Use Cases

NFTLend offers key functionalities for decentralized lending:

- **NFT-backed Loans**: Borrowers can secure loans by staking their NFTs as collateral, accessing liquidity without selling their digital assets.
- **P2P Lending with Interest**: Lenders can fund loans, earning interest over time, while benefiting from the security of NFT collateral.
- **Business**: Schedule the release of vested stocks or confidential documents.
- **Collateral Liquidation**: In case of default, lenders can claim the staked NFT, ensuring reduced risk in peer-to-peer lending.

## How It Works

### Requesting and Funding a Loan

1. **Create Loan Request**: Borrowers stake their ERC721 NFT as collateral and specify loan details such as the amount, interest rate, and repayment duration.
2. **NFT Collateral Locking**: The NFT is securely transferred to the smart contract, ensuring it cannot be withdrawn or sold by the borrower during the loan period.
3. **SLoan Funding by Lender**: Lenders review loan requests and can fund the loan by transferring the specified amount to the borrower. The NFT remains locked as collateral.
4. **Repayment with Interest**: Borrowers repay the loan, including the agreed interest, within the specified timeframe to reclaim their NFT.
5. **SCollateral Liquidation**: If the borrower fails to repay within the loan duration, the lender can claim the NFT as collateral, reducing the risk of lending.


### Solvers

The NFTLend Platform relies on a network of Lenders who provide the funds for borrowers. Lenders are incentivized by earning interest on the loan amount. In case of default, they can claim the NFT collateral as compensation, ensuring their investments are protected while offering borrowers access to quick liquidity.


## Screenshots

### MementoBox Interface
![Memento Interface](Images/1.jpg)

### Creating a Memento
![Memento Interface](Images/2.jpg)
![Memento Interface](Images/6.jpg)
![Memento Interface](Images/3.jpg)
![Memento Interface](Images/5.jpg)

### Viewing a Memento
![Memento Interface](Images/8.jpg)
![Memento Interface](Images/9.jpg)

### Solver written in Rust

![Memento Interface](Images/13.jpg)
![Memento Interface](Images/14.jpg)

## Roadmap

- **Automatic Liquidation**: If NFT prices fall dramatically, users have an option to automatically liquidate their assets.

- **Peer-to-pool Function**: Allows multiple lenders to contribute to a single loan and vice versa.


# Deployments

## Ethereum Sepolia contract address

[0xaddBCDd962FbCa2Cb1bfeCe88a2d05cA42D21811](https://sepolia.etherscan.io/tx/0xc7001e408fb781d00573113ba9e1155d06fbfe0bd8504b161860a5e3dc87a017)


## Scroll contract address

[0xc7f5c7f3819b107559567b556207b9fc0619e4a9](https://sepolia.scrollscan.com/tx/0x252188601a891b594ca6a0eb4abca9ce4f88130e4462ee56bfeddc7d1be993b3)

## Polygon Amoy contract address

[0xB62DE565F1BA01Ee87f4095535877550c6CdC2Ea](https://amoy.polygonscan.com/tx/0x11ff5f148ea2ab119bb947715eab8f908a81bfbefb5f6a0f78ebbc48fd9b7921)




## License

MIT


## Acknowledgements

Thank you for your interest in MementoBox! We hope our project inspires more privacy-preserving applications on the Ethereum blockchain.

---


