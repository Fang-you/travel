Component({
  properties: {
    orderId: {
      type: String,
      value: 'TR2026012401'
    },
    image: {
      type: String,
      value: '/images/order1.png'
    },
    title: {
      type: String,
      value: '川西秘境 | 4天3夜大学生拼车深度游'
    },
    date: {
      type: String,
      value: '2026-02-15'
    },
    price: {
      type: String,
      value: '1,280'
    },
    status: {
      type: String,
      value: 'pending'
    }
  },

  data: {
    statusText: '',
    statusColor: '',
    priceColor: '',
    opacity: ''
  },

  lifetimes: {
    attached() {
      this.updateStatus()
    }
  },

  observers: {
    'status': function() {
      this.updateStatus()
    }
  },

  methods: {
    updateStatus() {
      const statusMap = {
        pending: { text: '待支付', color: '#f97316', priceColor: '#f43f5e', opacity: '1' },
        completed: { text: '已完成', color: '#9ca3af', priceColor: '#4b5563', opacity: '0.8' },
        cancelled: { text: '已取消', color: '#d1d5db', priceColor: '#9ca3af', opacity: '0.5' }
      }
      const config = statusMap[this.properties.status] || statusMap.pending
      this.setData({
        statusText: config.text,
        statusColor: config.color,
        priceColor: config.priceColor,
        opacity: config.opacity
      })
    },

    onPay() {
      wx.navigateTo({
        url: `/pages/order/pay/pay?orderId=${this.properties.orderId}`
      })
    },

    onCancel() {
      this.triggerEvent('cancel', { orderId: this.properties.orderId })
    },

    onDetail() {
      wx.navigateTo({
        url: `/pages/order/order-detail/order-detail?orderId=${this.properties.orderId}`
      })
    },

    onReorder() {
      wx.navigateTo({
        url: `/pages/order/reorder/reorder?orderId=${this.properties.orderId}`
      })
    },

    onDelete() {
      this.triggerEvent('delete', { orderId: this.properties.orderId })
    },

    onActivity() {
      wx.navigateTo({
        url: `/pages/order/activity/activity?orderId=${this.properties.orderId}`
      })
    }
  }
})
