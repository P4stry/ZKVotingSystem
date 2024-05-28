<template>
  <main role="main" class="container">
    <div style="padding-top: 7rem" class="d-none d-lg-block"></div>
    <div class="row justify-content-md-center">
        <div class="text-center vstack gap-3">
          <h1>Create new Vote Proposal</h1>
          <h2>Enter the number of options: </h2>
          <input type="number" placeholder="Integer from 1 to 100" v-model="number" min="1" required />
          <button @click="generateInputBoxes">Confirm</button>
          <input
            v-for="index in inputBoxes"
            :key="index"
            type="text"
            class="inputBox"
          />
      </div>
    </div>
  </main>
</template>
  
<script lang="ts">
import { Component, Vue } from "vue-facing-decorator";

@Component
export default class CreateVote extends Vue {
  number = 0;
  inputBoxes = [];

  generateInputBoxes() {
    this.inputBoxes = Array.from({ length: this.number }, (_, i) => i);
  }
}
</script>