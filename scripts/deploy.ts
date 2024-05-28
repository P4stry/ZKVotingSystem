import * as fs from 'fs'
import { ethers } from "hardhat";
import { mimcSpongecontract } from 'circomlibjs'

const SEED = "mimcsponge";
const TREE_LEVELS = 20;

async function main() {
    const signers = await ethers.getSigners()
    const MiMCSponge = new ethers.ContractFactory(mimcSpongecontract.abi, mimcSpongecontract.createCode(SEED, 220), signers[0])
    const mimcsponge = await MiMCSponge.deploy()
    console.log(`MiMC sponge hasher address: ${mimcsponge.address}`)

    const Verifier = await ethers.getContractFactory("Verifier");
    const verifier = await Verifier.deploy();
    console.log(`Verifier address: ${verifier.address}`)

    const Router = await ethers.getContractFactory("Router");
    const router = await Router.deploy();
    console.log(`Router address: ${router.address}`)

    const VotingSystem = await ethers.getContractFactory("VotingSystem");
    const votingSystem = await VotingSystem.deploy(TREE_LEVELS, mimcsponge.address, verifier.address, 4, 4);
    console.log(`Voting system address: ${votingSystem.address}`)

    // add the 2nd hardhat account as a validator
    await votingSystem.registerValidator(signers[1].address)
    console.log(`Validator address: ${signers[1].address}`)

    fs.writeFileSync("static/contracts.json", JSON.stringify({
        mimc: mimcsponge.address,
        verifier: verifier.address,
        votingSystem: votingSystem.address,
        router: router.address
    }))
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});