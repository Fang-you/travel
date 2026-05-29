Page({
  data: {
    product: {
      id: 1,
      image: '/images/card1.png',
      title: '张家界奇观自驾拼团游',
      desc: '含星级酒店+当地向导',
      duration: '3天2晚',
      count: '已报 428 人',
      price: '399',
      originalPrice: '599',
      rating: '4.9',
      reviewCount: '2.3k',
      images: ['/images/detail1.png', '/images/detail2.png', '/images/detail3.png'],
      highlights: [
        { icon: '/images/icon_hotel.png', title: '精选住宿', desc: '4星级酒店双人标间' },
        { icon: '/images/icon_guide.png', title: '专业向导', desc: '当地资深导游全程陪同' },
        { icon: '/images/icon_car.png', title: '舒适出行', desc: '空调旅游大巴接送' },
        { icon: '/images/icon_food.png', title: '特色美食', desc: '含3正餐2早餐' }
      ],
      itinerary: [
        { day: 'Day 1', title: '出发 → 张家界', content: '各地出发前往张家界，入住酒店休息，晚上自由活动可逛当地夜市' },
        { day: 'Day 2', title: '天门山 → 玻璃栈道', content: '乘坐世界最长索道登天门山，体验惊险刺激的玻璃栈道，观赏天门洞奇观' },
        { day: 'Day 3', title: '森林公园 → 返程', content: '游览张家界国家森林公园，欣赏阿凡达取景地，下午返程' }
      ],
      includes: ['往返交通', '2晚住宿', '景点门票', '导游服务', '旅游保险'],
      excludes: ['个人消费', '单房差', '自费项目']
    }
  },

  onLoad(options) {
    if (options.id) {
      // 根据id获取商品详情（这里用假数据模拟）
      const productData = this.getProductById(options.id)
      if (productData) {
        this.setData({ product: productData })
      }
    }
  },

  getProductById(id) {
    const products = {
      '1': {
        id: 1,
        image: '/images/card1.png',
        title: '张家界奇观自驾拼团游',
        desc: '含星级酒店+当地向导',
        duration: '3天2晚',
        count: '已报 428 人',
        price: '399',
        originalPrice: '599',
        rating: '4.9',
        reviewCount: '2.3k',
        images: ['/images/detail1.png', '/images/detail2.png', '/images/detail3.png'],
        highlights: [
          { icon: '/images/icon_hotel.png', title: '精选住宿', desc: '4星级酒店双人标间' },
          { icon: '/images/icon_guide.png', title: '专业向导', desc: '当地资深导游全程陪同' },
          { icon: '/images/icon_car.png', title: '舒适出行', desc: '空调旅游大巴接送' },
          { icon: '/images/icon_food.png', title: '特色美食', desc: '含3正餐2早餐' }
        ],
        itinerary: [
          { day: 'Day 1', title: '出发 → 张家界', content: '各地出发前往张家界，入住酒店休息，晚上自由活动可逛当地夜市' },
          { day: 'Day 2', title: '天门山 → 玻璃栈道', content: '乘坐世界最长索道登天门山，体验惊险刺激的玻璃栈道，观赏天门洞奇观' },
          { day: 'Day 3', title: '森林公园 → 返程', content: '游览张家界国家森林公园，欣赏阿凡达取景地，下午返程' }
        ],
        includes: ['往返交通', '2晚住宿', '景点门票', '导游服务', '旅游保险'],
        excludes: ['个人消费', '单房差', '自费项目']
      },
      '2': {
        id: 2,
        image: '/images/card2.png',
        title: '重庆火锅之夜·赛博朋克团',
        desc: '大学生专项补贴计划',
        duration: '2天1晚',
        count: '已报 1.2k 人',
        price: '199',
        originalPrice: '299',
        rating: '4.8',
        reviewCount: '1.8k',
        images: ['/images/detail1.png', '/images/detail2.png', '/images/detail3.png'],
        highlights: [
          { icon: '/images/icon_hotel.png', title: '网红民宿', desc: '洪崖洞附近特色民宿' },
          { icon: '/images/icon_guide.png', title: '本地达人', desc: '重庆土著带你玩转山城' },
          { icon: '/images/icon_car.png', title: '轻轨漫游', desc: '体验穿楼轻轨李子坝站' },
          { icon: '/images/icon_food.png', title: '地道火锅', desc: '正宗九宫格老火锅' }
        ],
        itinerary: [
          { day: 'Day 1', title: '抵达 → 夜景之旅', content: '抵达重庆，入住民宿，晚上游览洪崖洞、千厮门大桥，品尝地道火锅' },
          { day: 'Day 2', title: '网红打卡 → 返程', content: '打卡李子坝轻轨站、磁器口古镇、解放碑，下午返程' }
        ],
        includes: ['1晚住宿', '火锅晚餐', '导游服务', '旅游保险'],
        excludes: ['往返交通', '个人消费', '其他餐食']
      },
      '3': {
        id: 3,
        image: '/images/card3.png',
        title: '星空之下·莫干山精致露营',
        desc: '提供全套装备+篝火晚会',
        duration: '1天',
        count: '已报 89 人',
        price: '99',
        originalPrice: '168',
        rating: '4.7',
        reviewCount: '856',
        images: ['/images/detail1.png', '/images/detail2.png', '/images/detail3.png'],
        highlights: [
          { icon: '/images/icon_hotel.png', title: '精致帐篷', desc: '双人豪华帐篷+睡袋' },
          { icon: '/images/icon_guide.png', title: '专业领队', desc: '户外达人全程指导' },
          { icon: '/images/icon_car.png', title: '免费接驳', desc: '高铁站免费接送' },
          { icon: '/images/icon_food.png', title: 'BBQ晚餐', desc: '户外烧烤+篝火晚会' }
        ],
        itinerary: [
          { day: 'Day 1', title: '集合 → 露营体验', content: '下午集合前往营地，搭建帐篷，傍晚BBQ烧烤，晚上篝火晚会+观星，次日早餐后返程' }
        ],
        includes: ['帐篷装备', 'BBQ晚餐', '早餐', '篝火晚会', '旅游保险'],
        excludes: ['往返交通', '个人消费']
      }
    }
    return products[id] || products['1']
  },

  onBuy() {
    const { product } = this.data
    wx.navigateTo({
      url: `/pages/index/checkout/checkout?id=${product.id}&title=${encodeURIComponent(product.title)}&price=${product.price}&image=${encodeURIComponent(product.image)}&desc=${encodeURIComponent(product.desc)}&duration=${encodeURIComponent(product.duration)}&count=${encodeURIComponent(product.count)}`
    })
  },

  onContactService() {
    wx.navigateTo({
      url: '/pages/mine/service/service'
    })
  },

  onShareAppMessage() {
    const { product } = this.data
    return {
      title: product.title,
      path: `/pages/index/product-detail/product-detail?id=${product.id}`
    }
  }
})
