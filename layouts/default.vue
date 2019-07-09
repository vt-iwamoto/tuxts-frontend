<template>
  <div>
    <b-navbar toggleable="lg" type="dark" variant="info">
      <b-navbar-brand to="/">
        Tuxts
      </b-navbar-brand>
    </b-navbar>
    <b-container>
      <b-row align-h="center">
        <b-col md="7" sm="12">
          <nuxt />
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<style>
h1,
div.list-group,
p {
  margin: 1rem 0;
}
</style>
