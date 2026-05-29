Page({
  data: {
    currentTab: 0,
    tabs: [
      { id: 0, name: '攻略' },
      { id: 1, name: '特价' },
      { id: 2, name: '关于我们' }
    ],
    dealsList: [
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
      },
      {
        id: 1,
        image: '/images/card1.png',
        title: '张家界奇观自驾拼团游',
        desc: '含星级酒店+当地向导',
        duration: '3天2晚',
        count: '已报 428 人',
        price: '399'
      }
    ],
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
      contact: {
        address: '浙江省杭州市西湖区文三路478号华星科技大厦15楼',
        email: 'contact@qulvxing.com',
        phone: '400-888-6666'
      }
    },
    cardList: [
      {
        id: 1,
        image: '/images/discover1.png',
        title: '大理洱海三天两夜穷游指南，人均500+',
        tag: '穷游',
        tagColor: 'rgba(0,0,0,0.3)',
        avatar: '/images/avatar1.png',
        author: '小鹿学姐',
        likes: '1.2w',
        aspectRatio: '4/5'
      },
      {
        id: 2,
        image: '/images/discover2.png',
        title: '【长沙出发】五一去贵州啦，缺2个姐妹拼车！',
        tag: '拼团',
        tagColor: '#f97316',
        avatar: '/images/avatar2.png',
        author: '旅行家阿杰',
        likes: '8.5k',
        aspectRatio: '1/1'
      },
      {
        id: 3,
        image: '/images/discover3.png',
        title: '上海周边：发现一个超适合发呆的避世古村',
        tag: '周末',
        tagColor: '#22c55e',
        avatar: '/images/avatar3.png',
        author: '草莓酱子',
        likes: '256',
        aspectRatio: '3/4'
      },
      {
        id: 4,
        image: '/images/discover4.png',
        title: '西藏专线机票半价！大学生专属优惠合集',
        tag: '特价',
        tagColor: 'rgba(0,0,0,0.3)',
        avatar: '/images/avatar4.png',
        author: '飞猪小助手',
        likes: '4.2w',
        aspectRatio: '4/5'
      }
    ]
  },

  onLoad(options) {

  },

  onTabChange(e) {
    const { index } = e.currentTarget.dataset
    this.setData({
      currentTab: index
    })
  },

  onCardTap(e) {
    const { id, title } = e.detail
    wx.navigateTo({
      url: `/pages/discover/detail/detail?id=${id}&title=${encodeURIComponent(title)}`
    })
  },

  onDealTap(e) {
    const { id } = e.currentTarget.dataset
    wx.navigateTo({
      url: `/pages/index/product-detail/product-detail?id=${id}`
    })
  },

  onDealBuy(e) {
    const { id, title, price, image, desc, duration, count } = e.detail
    wx.navigateTo({
      url: `/pages/index/checkout/checkout?id=${id}&title=${encodeURIComponent(title)}&price=${price}&image=${encodeURIComponent(image)}&desc=${encodeURIComponent(desc)}&duration=${encodeURIComponent(duration)}&count=${encodeURIComponent(count)}`
    })
  }
})
