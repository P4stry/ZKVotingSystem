<template>
    <h1>Dynamic Input Boxes</h1>
    <div>
    <input v-model="numberOfInputs" type="number" placeholder="Enter a number" />
    <button @click="createInputs">Confirm</button>
    </div>
    <div v-if="inputs.length > 0">
    <h2>Generated Input Boxes</h2>
    <div v-for="(input, index) in inputs" :key="index">
        <input type="text" :placeholder="'Input ' + (index + 1)" v-model="inputs[index]" />
    </div>
    </div>
  </template>
  
  <script>
  @Component
  export default class CreateVote extends{
    data() {
      return {
        numberOfInputs: '',
        inputs: []
      };
    },
    methods: {
      createInputs() {
        const num = parseInt(this.numberOfInputs);
        if (!isNaN(num) && num > 0) {
          this.inputs = Array(num).fill('');
        } else {
          this.inputs = [];
          alert('Please enter a valid positive number');
        }
      }
    }
  };
  </script>
