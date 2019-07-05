<template>
  <div>
    <b-navbar toggleable="lg" type="dark" variant="info">
      <b-navbar-brand to="/">
        Tuxts
      </b-navbar-brand>
    </b-navbar>
    <b-row align-h="center">
      <b-col cols="6">
        <nuxt />
      </b-col>
    </b-row>
  </div>
</template>

<style>
h1,
div.list-group,
p {
  margin: 1rem 0;
}
</style>
