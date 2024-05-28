<template>
    <main role="main" class="container">
        <div style="padding-top: 7rem" class="d-none d-lg-block"></div>
        <div class="row justify-content-md-center">
        <div class="col-lg-4">
            <div class="text-center vstack gap-3">
            <h1>Register Validator</h1>
            <div id="reader" width="400px"></div>
            <input type="text" placeholder="Validator Address" v-model="validatorAddress" />
            <button class="btn btn-info" @click="sendToBlockchain">
                Register Validator
            </button>
            <a href="#/validator" class="btn btn-primary">Back</a>
            </div>
        </div>
        </div>
    </main>
</template>
  
<script lang="ts">
import { Component, Vue } from "vue-facing-decorator";
import * as ethers from "ethers";

@Component
export default class ValidatorRegistration extends Vue {
    public validatorAddress = "";

    async sendToBlockchain() {
        const abi = [
            "function registerValidator(address _validator)",
        ];
        const provider = new ethers.providers.Web3Provider(
            (window as any).ethereum
        );
        await provider.send("eth_requestAccounts", []);
        const signer = provider.getSigner();
        const contracts = await (await fetch("contracts.json")).json();
        const contract = new ethers.Contract(contracts.zktreevote, abi, signer);
        if (!this.validatorAddress) {
            alert("Validator Address is required");
            return;
        }
        try {
            await contract.registerValidator(this.validatorAddress);
            alert("Validator registered successfully");
        } catch (e) {
            alert(e.reason);
        }
    }
}
</script>