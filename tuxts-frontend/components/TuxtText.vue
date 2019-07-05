<template>
  <b-list-group-item @click.self="showForm">
    <span v-show="!formShow" @click.self="showForm">{{ text.text }}</span>
    <b-form v-show="formShow">
      <b-form-group invalid-feedback="Text is required">
        <b-form-input
          v-show="formShow"
          ref="input"
          v-model="text.text"
          rows="3"
          :state="formState"
          required
        />
      </b-form-group>
      <b-button variant="outline-secondary" @click="hideForm">
        Cancel
      </b-button>
      <b-button variant="outline-danger" @click="modalShow = !modalShow">
        Delete
      </b-button>
      <b-button variant="outline-primary" @click="update">
        Update
      </b-button>
      <b-modal
        v-model="modalShow"
        hide-header
        cancel-variant="outline-secondary"
        ok-variant="outline-primary"
        @ok="$emit('delete', text, index)"
      >
        <p>Are you sure you want to delete this text?</p>
      </b-modal>
    </b-form>
  </b-list-group-item>
</template>

<script>
export default {
  props: ['text', 'index'],

  data() {
    return {
      formShow: false,
      modalShow: false,
      formState: null,
      originalText: this.text.text
    }
  },

  methods: {
    showForm() {
      if (!this.formShow) {
        this.formShow = true
        this.$refs.input.focus()
      }
    },

    hideForm() {
      this.formShow = false
      this.formState = null
      this.text.text = this.originalText
    },

    update() {
      const valid = this.$refs.input.checkValidity()
      if (!valid) {
        this.formState = 'invalid'
        return
      }

      if (this.text.text !== this.originalText) {
        this.$emit('update', this.text, this.index)
      }

      this.formShow = false
      this.modalShow = false
      this.formState = null
      this.originalText = this.text.text
    }
  }
}
</script>

<style>
div.list-group-item:hover {
  background-color: #f8f9fa;
  cursor: pointer;
}
</style>
