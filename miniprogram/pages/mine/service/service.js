Page({
  data: {
    phoneNumber: '400-888-6666',
    wechatId: 'QuLvXing_Service',
    inputValue: '',
    chatList: [
      {
        id: 1,
        role: 'ai',
        content: '您好！我是趣旅行AI客服小趣，很高兴为您服务。您可以直接输入问题，或点击下方快捷问题快速咨询~'
      }
    ],
    quickQuestions: [
      '如何取消订单？',
      '退款多久到账？',
      '如何修改出行人？',
      '发票如何开具？'
    ],
    isTyping: false,
    scrollToView: '',
    msgId: 1,
    // 预设答案库
    presetAnswers: {
      '取消订单': '您可以在"我的订单"中找到需要取消的订单，点击"取消订单"按钮即可。如果订单已支付，取消后款项将在1-3个工作日内原路退回。温馨提示：出行前24小时内取消可能会产生一定的手续费哦~',
      '退款': '退款一般会在1-3个工作日内原路退回到您的支付账户。如果超过3个工作日仍未收到，请联系人工客服处理。',
      '修改出行人': '您可以在订单详情页点击"修改出行人信息"进行修改。请注意：出行前24小时内可能无法修改，建议您提前确认好出行人信息。',
      '发票': '您可以在订单完成后，进入订单详情页，点击"申请发票"按钮进行开票。电子发票将在1-3个工作日内发送到您的邮箱。',
      '支付': '我们支持微信支付、支付宝等多种支付方式。如果支付遇到问题，请检查网络连接或尝试更换支付方式。',
      '行程': '您可以在订单详情页查看完整的行程安排，包括集合时间、地点、行程路线等信息。出行前一天，我们也会发送短信提醒。',
      '联系': '您可以拨打客服电话400-888-6666，或添加企业微信QuLvXing_Service联系我们。工作时间：9:00-21:00',
      '优惠': '您可以在"我的-优惠券"中查看可用优惠券。新用户注册即送50元优惠券，更多优惠活动请关注首页推荐~',
      '拼团': '拼团订单需要在规定时间内凑满人数才能成团。如果未成团，我们会全额退款。您也可以邀请好友一起拼团，成功率更高哦~',
      '保险': '我们的产品均包含旅游意外险，保障您的出行安全。如需了解保险详情，可在订单详情页查看保险条款。'
    }
  },

  onLoad(options) {},

  callPhone() {
    wx.makePhoneCall({
      phoneNumber: this.data.phoneNumber,
      fail: () => {
        wx.showToast({
          title: '拨打失败',
          icon: 'none'
        })
      }
    })
  },

  copyWechat() {
    wx.setClipboardData({
      data: this.data.wechatId,
      success: () => {
        wx.showToast({
          title: '已复制微信号',
          icon: 'success'
        })
      }
    })
  },

  onInput(e) {
    this.setData({
      inputValue: e.detail.value
    })
  },

  onQuickQuestion(e) {
    const question = e.currentTarget.dataset.question
    this.setData({
      inputValue: question
    })
    this.onSend()
  },

  onSend() {
    const { inputValue, chatList, msgId } = this.data
    if (!inputValue.trim()) return

    // 添加用户消息
    const userMsgId = msgId + 1
    const newChatList = [...chatList, {
      id: userMsgId,
      role: 'user',
      content: inputValue
    }]

    this.setData({
      chatList: newChatList,
      inputValue: '',
      msgId: userMsgId,
      isTyping: true,
      scrollToView: `msg-${userMsgId}`
    })

    // 模拟AI回复延迟
    setTimeout(() => {
      this.generateAIResponse(inputValue)
    }, 800)
  },

  generateAIResponse(question) {
    const { chatList, msgId, presetAnswers } = this.data
    
    // 匹配预设答案
    let answer = '抱歉，我暂时无法理解您的问题。您可以尝试换个方式描述，或者拨打客服电话400-888-6666获取人工帮助~'
    
    for (const keyword in presetAnswers) {
      if (question.includes(keyword)) {
        answer = presetAnswers[keyword]
        break
      }
    }

    const aiMsgId = msgId + 1
    const newChatList = [...chatList, {
      id: aiMsgId,
      role: 'ai',
      content: answer
    }]

    this.setData({
      chatList: newChatList,
      msgId: aiMsgId,
      isTyping: false,
      scrollToView: `msg-${aiMsgId}`
    })
  }
})
