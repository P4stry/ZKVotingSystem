<template>
    <main role="main" class="container">
      <div style="padding-top: 7rem" class="d-none d-lg-block"></div>
      <div class="row justify-content-md-center">
        <div class="col-lg-4">
          <div class="text-center vstack gap-3">
            <h1>Validator tool</h1>
            <a href="#/verifyVoters" class="btn btn-primary">Verify voter's eligibility</a>
            <a href="#/results" class="btn btn-primary">Results</a>
            <a href="#/" class="btn btn-primary">Back</a>
          </div>
        </div>
      </div>
    </main>
  </template>
  
  <script lang="ts">
  import { Component, Vue } from "vue-facing-decorator";
  
  @Component
  export default class Validator extends Vue {}
  </script>