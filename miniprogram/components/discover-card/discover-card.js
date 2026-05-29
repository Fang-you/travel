Component({
  properties: {
    image: {
      type: String,
      value: '/images/discover1.png'
    },
    title: {
      type: String,
      value: '大理洱海三天两夜穷游指南，人均500+'
    },
    tag: {
      type: String,
      value: '穷游'
    },
    tagColor: {
      type: String,
      value: 'rgba(0,0,0,0.3)'
    },
    avatar: {
      type: String,
      value: '/images/avatar1.png'
    },
    author: {
      type: String,
      value: '小鹿学姐'
    },
    likes: {
      type: String,
      value: '1.2w'
    },
    aspectRatio: {
      type: String,
      value: '4/5'
    },
    cardId: {
      type: Number,
      value: 0
    }
  },

  data: {

  },

  methods: {
    onTap() {
      this.triggerEvent('tap', {
        id: this.properties.cardId,
        title: this.properties.title
      })
    }
  }
})
