Page({
  data: {
    // 用户信息（后续可通过后端API替换）
    userInfo: {
      avatar: '/images/avatar.png',
      name: '林书豪',
      school: '浙江大学',
      location: '杭州 · 西湖区'
    },
    // 订单快捷入口
    orderShortcuts: [
      { id: 1, name: '待支付', icon: '/images/icon_wallet.png', bgColor: '#fff7ed', status: 'pending' },
      { id: 2, name: '已完成', icon: '/images/icon_suitcase.png', bgColor: '#f0fdf4', status: 'completed' },
      { id: 3, name: '已取消', icon: '/images/icon_bill.png', bgColor: '#f9fafb', status: 'cancelled' }
    ],
    // 功能菜单列表
    menuList: [
      { id: 1, title: '我的收藏', icon: '/images/icon_heart.png', bgColor: '#fdf2f8', badge: 0, url: '/pages/mine/favorites/favorites' },
      { id: 2, title: '我的拼团', icon: '/images/icon_group.png', bgColor: '#eff6ff', badge: 2, url: '/pages/mine/group/group' },
      { id: 3, title: '优惠券', icon: '/images/icon_ticket.png', bgColor: '#fffbeb', badge: 0, url: '/pages/mine/coupon/coupon' },
      { id: 4, title: '联系客服', icon: '/images/icon_chat.png', bgColor: '#ecfeff', badge: 0, url: '/pages/mine/service/service' },
      { id: 5, title: '设置', icon: '/images/icon_settings.png', bgColor: '#f1f5f9', badge: 0, url: '/pages/mine/settings/settings' }
    ]
  },

  onLoad(options) {},

  // 跳转到订单页（全部订单）
  goToOrders() {
    wx.switchTab({
      url: '/pages/order/order'
    })
  },

  // 跳转到订单页指定状态
  goToOrderStatus(e) {
    const { status } = e.currentTarget.dataset
    // 先跳转到订单页，通过全局变量或事件传递状态
    const app = getApp()
    app.globalData = app.globalData || {}
    app.globalData.orderTabStatus = status
    wx.switchTab({
      url: '/pages/order/order'
    })
  }
})
