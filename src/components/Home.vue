<template>
  <main role="main" class="container">
    <div style="padding-top: 7rem" class="d-none d-lg-block"></div>
    <div class="row justify-content-md-center">
      <div class="col-lg-4">
        <div class="text-center vstack gap-3">
          <h1>Scalable Voting System</h1>
            <div class = "content">
              <h2 class = "element">I'm a</h2>
              <a href="#/validator" class="btn btn-primary element">Validator</a>
              <a href="#/voter" class="btn btn-primary element">Voter</a>
          </div>
        </div>
      </div>
    </div>
  </main>
</template>

.content {
  display: table;
  height: 100%;
  width: 100%;
}

.element {
  display: table-cell;
  vertical-align: middle;
  text-align: center;
}


<script lang="ts">
import { Component, Vue } from "vue-facing-decorator";

@Component
export default class Home extends Vue {}
</script>