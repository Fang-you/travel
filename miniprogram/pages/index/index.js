Page({
  data: {
    currentCity: '上海',
    bannerList: [
      { id: 1, image: '/images/banner1.png' },
      { id: 2, image: '/images/banner2.png' },
      { id: 3, image: '/images/banner3.png' }
    ],
    cardList: [
      {
        id: 1,
        image: '/images/card1.png',
        title: '张家界奇观自驾拼团游',
        desc: '含星级酒店+当地向导',
        duration: '3天2晚',
        count: '已报 428 人',
        price: '399'
      },
      {
        id: 2,
        image: '/images/card2.png',
        title: '重庆火锅之夜·赛博朋克团',
        desc: '大学生专项补贴计划',
        duration: '2天1晚',
        count: '已报 1.2k 人',
        price: '199'
      },
      {
        id: 3,
        image: '/images/card3.png',
        title: '星空之下·莫干山精致露营',
        desc: '提供全套装备+篝火晚会',
        duration: '1天',
        count: '已报 89 人',
        price: '99'
      }
    ]
  },

  onLoad(options) {

  },

  goToHotList() {
    wx.navigateTo({
      url: '/pages/index/hot-list/hot-list'
    })
  },

  onCardTap(e) {
    const { id } = e.currentTarget.dataset
    wx.navigateTo({
      url: `/pages/index/product-detail/product-detail?id=${id}`
    })
  },

  onCardBuy(e) {
    const { id, title, price, image, desc, duration, count } = e.detail
    // 跳转到支付页面，传递商品信息
    wx.navigateTo({
      url: `/pages/index/checkout/checkout?id=${id}&title=${encodeURIComponent(title)}&price=${price}&image=${encodeURIComponent(image)}&desc=${encodeURIComponent(desc)}&duration=${encodeURIComponent(duration)}&count=${encodeURIComponent(count)}`
    })
  },

  onShareAppMessage() {
    return {
      title: '趣旅行 - 大学生旅游首选平台',
      path: '/pages/index/index'
    }
  }
})