<template>
  <component :is="getMainComponent()"></component>
</template>

<script lang="ts">
import { Component, Vue } from "vue-facing-decorator";

import Home from "./Home.vue";
import Validator from "./Validator.vue"; // validators
import VerifyVoters from "./VerifyVoters.vue"; // validators
import ValidatorRegistration from "./ValidatorRegistration.vue"; // validators
import VoterRegistration from "./VoterRegistration.vue"; // voters
import Vote from "./Vote.vue"; // voters
import Voter from "./Voter.vue"; // voters
import Results from "./Results.vue"; // both

@Component
export default class App extends Vue {
  public locationHash = "";

  created() {
    this.locationHash = window.location.hash;
  }

  mounted() {
    window.addEventListener("hashchange", () => {
      this.locationHash = window.location.hash;
    });
  }

  getMainComponent() {
    const currentPath = this.locationHash.slice(1) || "/";
    if (currentPath == "/") return Home;
    
    if (currentPath == "/validator") return Validator;
    if (currentPath == "/verifyVoters") return VerifyVoters;
    if (currentPath == "/registerValidator") return ValidatorRegistration;

    if (currentPath == "/voter") return Voter;
    if (currentPath == "/voterRegistration") return VoterRegistration;
    if (currentPath == "/vote") return Vote;

    if (currentPath == "/results") return Results;
  }
}
</script>