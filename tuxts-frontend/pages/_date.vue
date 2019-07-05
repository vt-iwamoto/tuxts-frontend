<template>
  <div>
    <b-navbar toggleable="lg" type="dark" variant="info">
      <b-navbar-brand to="/">
        Tuxts
      </b-navbar-brand>
    </b-navbar>

    <b-row align-h="center">
      <b-col cols="6">
        <h1>{{ date }}</h1>

        <ul v-if="texts.length">
          <li v-for="text in texts" :key="text.id">
            {{ text.text }}
          </li>
        </ul>

        <p v-else>
          No texts.
        </p>

        <hr />

        <ul>
          <li v-if="nextDateHref">
            Next date:
            <nuxt-link :to="nextDateHref">
              {{ nextDateText }}
            </nuxt-link>
          </li>
          <li>
            Previous date:
            <nuxt-link :to="prevDateHref">
              {{ prevDateText }}
            </nuxt-link>
          </li>
        </ul>
      </b-col>
    </b-row>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  validate({ params }) {
    return /^\d{4}-\d{2}-\d{2}$/.test(params.date)
  },

  head() {
    return { title: 'Tuxts / ' + this.date }
  },

  async asyncData({ params }) {
    const date = params.date
    const { data } = await axios.get(
      'https://tuxts-bff.herokuapp.com/texts?date=' + date
    )
    const moment = require('moment-timezone')

    const today = moment()
      .tz('Asia/Tokyo')
      .startOf('date')

    const nextDate = moment(date)
      .tz('Asia/Tokyo')
      .add(1, 'days')
    let nextDateHref
    if (nextDate.isBefore(today)) {
      nextDateHref = nextDate.format('YYYY-MM-DD')
    } else if (nextDate.isSame(today)) {
      nextDateHref = nextDate.format('/')
    }
    const nextDateText = nextDate.format('YYYY-MM-DD')

    const prevDate = moment(date)
      .tz('Asia/Tokyo')
      .add(-1, 'days')
    const prevDateHref = prevDate.format('YYYY-MM-DD')
    const prevDateText = prevDateHref

    return {
      date: date,
      texts: data,
      nextDateHref: nextDateHref,
      nextDateText: nextDateText,
      prevDateHref: prevDateHref,
      prevDateText: prevDateText
    }
  }
}
</script>

<style></style>
