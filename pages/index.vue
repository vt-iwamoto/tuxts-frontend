<template>
  <div>
    <h1>{{ date }}</h1>

    <b-list-group v-if="texts.length">
      <tuxt-text
        v-for="(text, index) in texts"
        :key="text.id"
        :text="text"
        :index="index"
        @delete="deleteText"
        @update="updateText"
      />
    </b-list-group>

    <p v-else class="text-secondary">
      No texts.
    </p>

    <div class="text-right">
      <b-button variant="outline-secondary" @click="modalShow = !modalShow">
        Add text
      </b-button>
    </div>

    <b-modal
      v-model="modalShow"
      hide-header
      cancel-variant="outline-secondary"
      ok-variant="outline-primary"
      ok-title="Add"
      @ok="addText"
      @hidden="newTextState = null"
    >
      <b-form-group invalid-feedback="Text is required">
        <b-form-input
          ref="newText"
          v-model="newText"
          :state="newTextState"
          rows="3"
          max-rows="8"
          required
        />
      </b-form-group>
    </b-modal>

    <hr />

    <div class="float-right">
      Previous:
      <nuxt-link :to="prevDate">
        {{ prevDate }}
      </nuxt-link>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import TuxtText from '~/components/TuxtText.vue'

export default {
  components: {
    TuxtText
  },

  head() {
    return { title: 'Tuxts: Texts with Nuxt.js' }
  },

  data() {
    return { modalShow: false, newText: '', newTextState: null }
  },

  async asyncData() {
    const moment = require('moment-timezone')
    const today = moment().tz('Asia/Tokyo')
    const date = today.format('YYYY-MM-DD')
    const { data } = await axios.get(
      'https://tuxts-bff.herokuapp.com/texts?date=' + date
    )
    return {
      date: date,
      texts: data,
      prevDate: today.add(-1, 'days').format('YYYY-MM-DD')
    }
  },

  methods: {
    async addText(event) {
      event.preventDefault()
      const valid = this.$refs.newText.checkValidity()
      if (!valid) {
        this.newTextState = 'invalid'
        return
      }

      await axios
        .post('https://tuxts-bff.herokuapp.com/texts', { text: this.newText })
        .then(
          function(response) {
            this.texts.push(response.data)
          }.bind(this)
        )

      this.newText = ''
      this.$nextTick(() => {
        this.modalShow = false
      })
    },

    async deleteText(text, index) {
      this.texts.splice(index, 1)
      await axios.delete('https://tuxts-bff.herokuapp.com/texts/' + text.id)
    },

    async updateText(text, index) {
      await axios.put('https://tuxts-bff.herokuapp.com/texts/' + text.id, {
        text: text.text
      })
    }
  }
}
</script>

<style></style>
