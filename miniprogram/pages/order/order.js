Page({
  data: {
    currentTab: 0,
    tabs: [
      { id: 0, name: '全部', status: 'all' },
      { id: 1, name: '待支付', status: 'pending' },
      { id: 2, name: '已完成', status: 'completed' },
      { id: 3, name: '已取消', status: 'cancelled' }
    ],
    orderList: [
      {
        id: 1,
        orderId: 'TR2026012401',
        image: '/images/order1.png',
        title: '川西秘境 | 4天3夜大学生拼车深度游',
        date: '2026-02-15',
        price: '1,280',
        status: 'pending'
      },
      {
        id: 2,
        orderId: 'TR2026011005',
        image: '/images/order2.png',
        title: '大理洱海 | 寒假特惠自由行套餐',
        date: '2026-01-15',
        price: '899',
        status: 'completed'
      },
      {
        id: 3,
        orderId: 'TR2026010502',
        image: '/images/order3.png',
        title: '哈尔滨冰雪大世界 | 学生团一日游',
        date: '2026-01-08',
        price: '260',
        status: 'cancelled'
      }
    ],
    filteredList: []
  },

  onLoad(options) {
    this.filterOrders()
  },

  onShow() {
    // 检查是否从"我的"页面跳转过来并带有指定状态
    const app = getApp()
    if (app.globalData && app.globalData.orderTabStatus) {
      const status = app.globalData.orderTabStatus
      const { tabs } = this.data
      const tabIndex = tabs.findIndex(tab => tab.status === status)
      if (tabIndex !== -1) {
        this.setData({
          currentTab: tabIndex
        })
        this.filterOrders()
      }
      // 清除状态，避免重复触发
      app.globalData.orderTabStatus = null
    }
  },

  onTabChange(e) {
    const { index } = e.currentTarget.dataset
    this.setData({
      currentTab: index
    })
    this.filterOrders()
  },

  filterOrders() {
    const { currentTab, tabs, orderList } = this.data
    const status = tabs[currentTab].status
    
    if (status === 'all') {
      this.setData({
        filteredList: orderList
      })
    } else {
      this.setData({
        filteredList: orderList.filter(item => item.status === status)
      })
    }
  },

  onOrderCancel(e) {
    const { orderId } = e.detail
    wx.showModal({
      title: '提示',
      content: '确定要取消该订单吗？',
      success: (res) => {
        if (res.confirm) {
          wx.showToast({
            title: '订单已取消',
            icon: 'success'
          })
        }
      }
    })
  },

  onOrderDelete(e) {
    const { orderId } = e.detail
    wx.showModal({
      title: '提示',
      content: '确定要删除该订单吗？',
      success: (res) => {
        if (res.confirm) {
          wx.showToast({
            title: '订单已删除',
            icon: 'success'
          })
        }
      }
    })
  }
})
