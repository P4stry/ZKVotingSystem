<template>
  <main role="main" class="container">
    <div style="padding-top: 7rem" class="d-none d-lg-block"></div>
    <div class="row justify-content-md-center">
      <div class="col-lg-4">
        <div class="text-center vstack gap-3">
          <h1>Scalable Voting System</h1>
          <h2>I'm a</h2>
          <a href="#/validator" class="btn btn-primary">Voter</a>
          <a href="#/voter" class="btn btn-primary">Validator</a>
        </div>
      </div>
    </div>
  </main>
</template>

<script lang="ts">
import { Component, Vue } from "vue-facing-decorator";

@Component
export default class Home extends Vue {}
</script>