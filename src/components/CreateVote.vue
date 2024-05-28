<template>
  <main role="main" class="container">
    <div style="padding-top: 7rem" class="d-none d-lg-block"></div>
    <div class="row justify-content-md-center">
      <div class="col-lg-4">
        <div class="text-center vstack gap-3">
          <h1>Create new Vote Proposal</h1>
          <h2>Enter the voting duration (days): </h2>
          <input type="number" placeholder="Integer from 1 to 100" v-model="duration" min="1" required />
          <h2>Enter the number of options: </h2>
          <input type="number" placeholder="Integer from 1 to 100" v-model="number" min="1" required />
          <button class="btn btn-info" @click="generateInputBoxes">Confirm</button>
          <input
            placeholder="Option"
            v-for="(value, index) in inputBoxes"
            :key="index"
            v-model="inputBoxes[index]"
            type="text"
          />
          <button class="btn btn-info" @click="createVote">Create</button>
        </div>
      </div>
    </div>
  </main>
</template>

<script lang="ts">
import { Component, Vue } from "vue-facing-decorator";
import * as ethers from "ethers";

@Component
export default class CreateVote extends Vue {
  duration = 0;
  number = 0;
  inputBoxes = [];

  generateInputBoxes() {
    this.inputBoxes = Array.from({ length: this.number }, (_, i) => i);
  }

  async createVote() {
    // console.log("Recorded values:", this.inputBoxes);
    // console.log("Duration:", this.duration);
    // this.inputBoxes.forEach((value, index) => {
    //   console.log(`Option ${index + 1}: ${value}`);
    // });
    const TREE_LEVELS = 20;
    const provider = new ethers.providers.Web3Provider(
      (window as any).ethereum
    );
    await provider.send("eth_requestAccounts", []);
    const signer = provider.getSigner();
    const contracts = await (await fetch("contracts.json")).json();
    
    const factory = await (await fetch("VotingSystem.json")).json();
    const VotingSystem = new ethers.ContractFactory(factory.abi, factory.bytecode, signer);
    const votingSystem = await VotingSystem.deploy(TREE_LEVELS, contracts.mimc, contracts.verifier, this.number, this.duration);
    console.log(`Voting system address: ${votingSystem.address}`);
    
    const signerAddress = await signer.getAddress();
    await votingSystem.registerValidator(signerAddress)
    console.log(`Validator address: ${signerAddress}`)
  }
}
</script>