# zktree-vote
Anonymous voting on Ethereum blockchain using zero knowledge proof

## Usage

- Install wget (by `apt-get install wget` on Ubuntu/Debian or `brew install wget` on MacOS)
- Install the project dependencies and prepare by `npm install` in the project directory
- Start a Hardhat node by `npx hardhat node` in the project directory
- In another terminal deploy the smartcontract by `npm run deploy`
- Start the app by `npm start`

If the front-end is not loaded correctly, try `npm run build` then `npm start`

The app uses MetaMask to connect the blockchain, so the MetaMask extension have to be installed, and connected to the Hardhat local node. 

[Connect Metamask wallet to local Hardhat network](https://medium.com/@kaishinaw/connecting-metamask-with-a-local-hardhat-network-7d8cea604dc6)

The smart contract owner is the first Hardhat account, and the second account is set as a validator by the deployment script (Can set in deploy.ts).

For more details, please read my article on [Medium](https://thebojda.medium.com/how-i-built-an-anonymous-voting-system-on-the-ethereum-blockchain-using-zero-knowledge-proof-d5ab286228fd)
