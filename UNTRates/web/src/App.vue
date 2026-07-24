<script setup>
  import { RouterLink, RouterView } from 'vue-router'
  import {BApp} from 'bootstrap-vue-next'
  import Header from './components/inc/Header.vue';
</script>

<template>
  <BApp>
    <Header></Header>
    <RouterView />
  </BApp>
</template>

<style scoped>

</style>
