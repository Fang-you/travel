Page({
  data: {
    orderId: ''
  },

  onLoad(options) {
    if (options.orderId) {
      this.setData({
        orderId: options.orderId
      })
    }
  }
})
