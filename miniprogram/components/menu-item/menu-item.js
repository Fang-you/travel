Component({
  properties: {
    icon: {
      type: String,
      value: '/images/icon_heart.png'
    },
    title: {
      type: String,
      value: '我的收藏'
    },
    bgColor: {
      type: String,
      value: '#fdf2f8'
    },
    iconColor: {
      type: String,
      value: '#ec4899'
    },
    badge: {
      type: Number,
      value: 0
    },
    url: {
      type: String,
      value: ''
    }
  },

  methods: {
    onTap() {
      if (this.properties.url) {
        wx.navigateTo({
          url: this.properties.url
        })
      }
    }
  }
})
