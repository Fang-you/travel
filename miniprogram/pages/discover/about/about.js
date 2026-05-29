Page({
  data: {
    companyInfo: {
      name: '趣旅行',
      slogan: '让每一次旅行都充满惊喜',
      foundedYear: '2020',
      foundedMonth: '06',
      mission: '为大学生提供高性价比、安全可靠的旅行服务',
      vision: '成为中国最受大学生信赖的旅行平台',
      values: [
        { icon: '/images/icon_heart_fill.png', title: '用户至上', desc: '始终把用户体验放在第一位' },
        { icon: '/images/icon_shield.png', title: '安全可靠', desc: '严格筛选供应商，保障出行安全' },
        { icon: '/images/icon_price.png', title: '高性价比', desc: '大学生专属优惠，让旅行更实惠' },
        { icon: '/images/icon_innovation.png', title: '持续创新', desc: '不断优化产品，提升服务体验' }
      ],
      milestones: [
        { year: '2020', month: '06', event: '趣旅行正式成立于杭州' },
        { year: '2021', month: '03', event: '获得天使轮融资500万' },
        { year: '2021', month: '09', event: '用户突破10万，覆盖100+高校' },
        { year: '2022', month: '06', event: '推出拼团功能，月活跃用户破50万' },
        { year: '2023', month: '01', event: '获得A轮融资2000万' },
        { year: '2023', month: '12', event: '累计服务用户超过200万' },
        { year: '2024', month: '06', event: '入选"中国最具潜力旅游创业公司TOP10"' },
        { year: '2025', month: '01', event: '全面升级品牌，开启新征程' }
      ],
      stats: [
        { number: '200万+', label: '累计用户' },
        { number: '500+', label: '合作高校' },
        { number: '10000+', label: '精选线路' },
        { number: '98%', label: '好评率' }
      ],
      partners: [
        '/images/partner1.png',
        '/images/partner2.png',
        '/images/partner3.png',
        '/images/partner4.png'
      ],
      contact: {
        address: '浙江省杭州市西湖区文三路478号华星科技大厦15楼',
        email: 'contact@qulvxing.com',
        phone: '400-888-6666'
      }
    }
  },

  onLoad(options) {},

  onShareAppMessage() {
    return {
      title: '趣旅行 - 让每一次旅行都充满惊喜',
      path: '/pages/discover/about/about'
    }
  }
})
