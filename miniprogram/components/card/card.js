Component({
  properties: {
    id: {
      type: Number,
      value: 1
    },
    image: {
      type: String,
      value: '/images/default_card.png'
    },
    title: {
      type: String,
      value: '张家界奇观自驾拼团游'
    },
    desc: {
      type: String,
      value: '含星级酒店+当地向导'
    },
    duration: {
      type: String,
      value: '3天2晚'
    },
    count: {
      type: String,
      value: '已报 428 人'
    },
    price: {
      type: String,
      value: '399'
    }
  },

  data: {

  },

  methods: {
    onTap() {
      this.triggerEvent('tap')
    },

    onBuy() {
      this.triggerEvent('buy', {
        id: this.properties.id || 1,
        title: this.properties.title,
        price: this.properties.price,
        image: this.properties.image,
        desc: this.properties.desc,
        duration: this.properties.duration,
        count: this.properties.count
      })
    }
  }
})
