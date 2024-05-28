<template>
    <div id="inputContainer">
      <label for="numberInput">Enter a number: </label>
      <input type="number" v-model="number" min="1" required />
      <button @click="generateInputBoxes">Confirm</button>
    </div>
    <div id="inputBoxes">
      <input
        v-for="index in inputBoxes"
        :key="index"
        type="text"
        class="inputBox"
      />
    </div>
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