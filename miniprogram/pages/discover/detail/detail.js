Page({
  data: {
    id: 0,
    title: ''
  },

  onLoad(options) {
    if (options.id) {
      this.setData({
        id: options.id,
        title: options.title || ''
      })
    }
  }
})
