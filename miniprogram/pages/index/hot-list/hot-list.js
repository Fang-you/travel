Page({
  data: {
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
      },
      {
        id: 4,
        image: '/images/card4.png',
        title: '西安古城墙骑行一日游',
        desc: '含专业领队+单车租赁',
        duration: '1天',
        count: '已报 256 人',
        price: '128'
      },
      {
        id: 5,
        image: '/images/card5.png',
        title: '成都熊猫基地+都江堰双日游',
        desc: '含门票+接送+住宿',
        duration: '2天1晚',
        count: '已报 512 人',
        price: '458'
      },
      {
        id: 6,
        image: '/images/card6.png',
        title: '厦门鼓浪屿文艺小清新之旅',
        desc: '含船票+民宿+下午茶',
        duration: '3天2晚',
        count: '已报 328 人',
        price: '599'
      },
      {
        id: 7,
        image: '/images/card7.png',
        title: '青海湖环湖骑行挑战赛',
        desc: '专业装备+补给站+奖牌',
        duration: '4天3晚',
        count: '已报 156 人',
        price: '888'
      },
      {
        id: 8,
        image: '/images/card8.png',
        title: '云南大理丽江深度游',
        desc: '含机票+酒店+当地交通',
        duration: '5天4晚',
        count: '已报 678 人',
        price: '1280'
      },
      {
        id: 9,
        image: '/images/card9.png',
        title: '桂林阳朔山水画廊漂流',
        desc: '含竹筏漂流+特色午餐',
        duration: '2天1晚',
        count: '已报 445 人',
        price: '368'
      },
      {
        id: 10,
        image: '/images/card10.png',
        title: '北京故宫长城经典两日游',
        desc: '含门票+导游+酒店',
        duration: '2天1晚',
        count: '已报 892 人',
        price: '528'
      }
    ]
  },

  onLoad(options) {},

  onCardTap(e) {
    const { id } = e.currentTarget.dataset
    wx.navigateTo({
      url: `/pages/index/product-detail/product-detail?id=${id}`
    })
  },

  onCardBuy(e) {
    const { id, title, price, image, desc, duration, count } = e.detail
    wx.navigateTo({
      url: `/pages/index/checkout/checkout?id=${id}&title=${encodeURIComponent(title)}&price=${price}&image=${encodeURIComponent(image)}&desc=${encodeURIComponent(desc)}&duration=${encodeURIComponent(duration)}&count=${encodeURIComponent(count)}`
    })
  }
})
