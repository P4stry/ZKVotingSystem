<template>
  <main role="main" class="container">
    <div style="padding-top: 7rem" class="d-none d-lg-block"></div>
    <div class="row justify-content-md-center">
      <div class="col-lg-4">
        <div class="text-center vstack gap-3">
          <h1>Vote</h1>
          <h2>Enter the ID of Proposal: </h2>
          <input type="number" placeholder="The ID of Vote Proposal" v-model="proposalId" />
          <button class="btn btn-info" @click="getVoteProposal">Confirm</button>
          <input
            v-for="(value, index) in options"
            :key = "value"
            v-model="options[index]"
            type="radio"
            class="btn-check"
          />
          <h2>Expire in {{ expiry }} s</h2>
          Choose one option
          <div class="btn-group-vertical" role="group">
            <input
              type="radio"
              class="btn-check"
              name="vbtn-radio"
              id="vbtn-radio1"
              @click="option = 1"
            />
            <label class="btn btn-outline-dark" for="vbtn-radio1"
              >Apple</label
            >
            <input
              type="radio"
              class="btn-check"
              name="vbtn-radio"
              id="vbtn-radio2"
              @click="option = 2"
            />
            <label class="btn btn-outline-dark" for="vbtn-radio2"
              >Banana</label
            >
            <input
              type="radio"
              class="btn-check"
              name="vbtn-radio"
              id="vbtn-radio3"
              @click="option = 3"
            />
            <label class="btn btn-outline-dark" for="vbtn-radio3"
              >Orange</label
            >
            <input
              type="radio"
              class="btn-check"
              name="vbtn-radio"
              id="vbtn-radio4"
              @click="option = 4"
            />
            <label class="btn btn-outline-dark" for="vbtn-radio4"
              >Pear</label
            >
          </div>
          <button class="btn btn-info" @click="sendToBlockchain">
            Confirm vote
          </button>
          <a href="#/voter" class="btn btn-primary">Back</a>
        </div>
      </div>
    </div>
  </main>
</template>

<script lang="ts">
import { Component, Vue } from "vue-facing-decorator";
import * as ethers from "ethers";
import { calculateMerkleRootAndZKProof } from "zk-merkle-tree";

// the default verifier is for 20 levels, for different number of levels, you need a new verifier circuit
const TREE_LEVELS = 20;

@Component
export default class Vote extends Vue {
  public proposalId = 0;
  public options = [];
  public expiry = 0;
  public option = 0;

  mounted() {
    this.init();
  }

  async init() {
    const abi = [
      "function getExpiry() external view returns (uint)",
    ];
    const provider = new ethers.providers.Web3Provider(
      (window as any).ethereum
    );
    const signer = provider.getSigner();
    const contracts = await (await fetch("contracts.json")).json();
    const contract = new ethers.Contract(contracts.votingSystem, abi, signer);
    this.expiry = (await contract.getExpiry()).toString();
    console.log(this.expiry);
  }

  async getVoteProposal() {

    const abi = [
      "function getVoteProposal(uint id) view public returns (address, string memory, uint, string[] memory)"
    ];
    const provider = new ethers.providers.Web3Provider(
      (window as any).ethereum
    );
    await provider.send("eth_requestAccounts", []);
    const signer = provider.getSigner();
    const contracts = await (await fetch("contracts.json")).json();
    const contract = new ethers.Contract(contracts.router, abi, signer);
    const proposal = await contract.getVoteProposal(this.proposalId);
    console.log(proposal);
  }

  async sendToBlockchain() {
    if (!this.option) {
      alert("Please choose one!");
      return;
    }

    const commitment = JSON.parse(
      localStorage.getItem("zktree-vote-commitment")
    );
    if (!commitment) {
      alert("No commitment generated, please register!");
      return;
    }

    const abi = [
      "function vote(uint _option,uint256 _nullifier,uint256 _root,uint[2] memory _proof_a,uint[2][2] memory _proof_b,uint[2] memory _proof_c)",
    ];
    const provider = new ethers.providers.Web3Provider(
      (window as any).ethereum
    );
    await provider.send("eth_requestAccounts", []);
    const signer = provider.getSigner();
    const contracts = await (await fetch("contracts.json")).json();
    const contract = new ethers.Contract(contracts.votingSystem, abi, signer);
    const cd = await calculateMerkleRootAndZKProof(
      contracts.votingSystem, // Address of the VotingSystem contract, stored in static/contracts.json
      signer,
      TREE_LEVELS,
      commitment,
      "verifier.zkey"
    );
    try {
      await contract.vote(
        this.option,
        cd.nullifierHash,
        cd.root,
        cd.proof_a,
        cd.proof_b,
        cd.proof_c
      );
    } catch (e) {
      alert(e.reason);
    }
  }
}
</script>