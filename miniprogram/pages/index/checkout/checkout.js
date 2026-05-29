Page({
  data: {
    product: {
      id: 1,
      image: '/images/card1.png',
      title: '张家界奇观自驾拼团游',
      desc: '含星级酒店+当地向导',
      duration: '3天2晚',
      count: '已报 428 人',
      price: '399'
    },
    quantity: 1,
    totalPrice: 399,
    contactName: '',
    contactPhone: '',
    selectedDate: '',
    dateList: [
      '2026-02-01',
      '2026-02-08',
      '2026-02-15',
      '2026-02-22',
      '2026-03-01'
    ]
  },

  onLoad(options) {
    if (options.title) {
      const product = {
        id: options.id || 1,
        image: decodeURIComponent(options.image || '/images/card1.png'),
        title: decodeURIComponent(options.title),
        desc: decodeURIComponent(options.desc || ''),
        duration: decodeURIComponent(options.duration || ''),
        count: decodeURIComponent(options.count || ''),
        price: options.price || '399'
      }
      this.setData({
        product,
        totalPrice: parseInt(product.price)
      })
    }
  },

  onQuantityMinus() {
    if (this.data.quantity > 1) {
      const quantity = this.data.quantity - 1
      this.setData({
        quantity,
        totalPrice: quantity * parseInt(this.data.product.price)
      })
    }
  },

  onQuantityPlus() {
    const quantity = this.data.quantity + 1
    this.setData({
      quantity,
      totalPrice: quantity * parseInt(this.data.product.price)
    })
  },

  onDateSelect(e) {
    const { date } = e.currentTarget.dataset
    this.setData({
      selectedDate: date
    })
  },

  onNameInput(e) {
    this.setData({
      contactName: e.detail.value
    })
  },

  onPhoneInput(e) {
    this.setData({
      contactPhone: e.detail.value
    })
  },

  onPay() {
    const { contactName, contactPhone, selectedDate, quantity, totalPrice, product } = this.data

    if (!contactName) {
      wx.showToast({ title: '请输入联系人姓名', icon: 'none' })
      return
    }
    if (!contactPhone) {
      wx.showToast({ title: '请输入联系电话', icon: 'none' })
      return
    }
    if (!selectedDate) {
      wx.showToast({ title: '请选择出行日期', icon: 'none' })
      return
    }

    wx.showModal({
      title: '确认支付',
      content: `订单金额：¥${totalPrice}\n商品：${product.title}\n数量：${quantity}人\n出行日期：${selectedDate}`,
      confirmText: '立即支付',
      success: (res) => {
        if (res.confirm) {
          wx.showLoading({ title: '支付中...' })
          setTimeout(() => {
            wx.hideLoading()
            wx.showToast({
              title: '支付成功',
              icon: 'success',
              duration: 2000
            })
            setTimeout(() => {
              wx.switchTab({
                url: '/pages/order/order'
              })
            }, 2000)
          }, 1500)
        }
      }
    })
  }
})
