Component({
  properties: {
    placeholder: {
      type: String,
      value: '寒假去哪儿？搜特价穷游'
    }
  },

  data: {
    value: ''
  },

  methods: {
    onInput(e) {
      this.setData({
        value: e.detail.value
      })
      this.triggerEvent('input', { value: e.detail.value })
    },

    onFocus() {
      this.triggerEvent('focus')
    },

    onBlur() {
      this.triggerEvent('blur')
    },

    onSearch() {
      this.triggerEvent('search', { value: this.data.value })
    }
  }
})
