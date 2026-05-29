-- ============================================================
-- 趣旅行小程序数据库建表脚本
-- 数据库名: trip_db
-- 表数量: 25张
-- 符合第三范式(3NF)
-- ============================================================

-- 创建数据库
CREATE DATABASE IF NOT EXISTS trip_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE trip_db;

-- ============================================================
-- 一、用户模块 (3张表)
-- ============================================================

-- 1. 管理员角色表
CREATE TABLE IF NOT EXISTS admin_roles (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    name VARCHAR(50) NOT NULL COMMENT '角色名称',
    permissions TEXT COMMENT '权限列表(JSON格式)',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员角色表';

-- 2. 管理员表
CREATE TABLE IF NOT EXISTS admin_users (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    username VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
    password VARCHAR(255) NOT NULL COMMENT '密码(加密存储)',
    real_name VARCHAR(50) COMMENT '真实姓名',
    role_id INT COMMENT '角色ID',
    status TINYINT DEFAULT 1 COMMENT '状态(0禁用/1正常)',
    last_login_at DATETIME COMMENT '最后登录时间',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (role_id) REFERENCES admin_roles(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员表';

-- 3. 地区表 (需要先创建，因为users表依赖它)
CREATE TABLE IF NOT EXISTS regions (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    name VARCHAR(50) NOT NULL COMMENT '地区名称',
    parent_id INT DEFAULT 0 COMMENT '父级ID(0为顶级)',
    level TINYINT NOT NULL COMMENT '层级(1省/2市/3区)',
    is_hot TINYINT DEFAULT 0 COMMENT '是否热门目的地',
    sort_order INT DEFAULT 0 COMMENT '排序',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    INDEX idx_parent_id (parent_id),
    INDEX idx_level (level),
    INDEX idx_is_hot (is_hot)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='地区表';

-- 4. 用户表
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    openid VARCHAR(64) NOT NULL UNIQUE COMMENT '微信openid',
    unionid VARCHAR(64) COMMENT '微信unionid',
    nickname VARCHAR(50) COMMENT '昵称',
    avatar VARCHAR(255) COMMENT '头像URL',
    phone VARCHAR(20) COMMENT '手机号',
    gender TINYINT DEFAULT 0 COMMENT '性别(0未知/1男/2女)',
    birthday DATE COMMENT '生日',
    region_id INT COMMENT '所在地区ID',
    status TINYINT DEFAULT 1 COMMENT '状态(0禁用/1正常)',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (region_id) REFERENCES regions(id) ON DELETE SET NULL,
    INDEX idx_openid (openid),
    INDEX idx_phone (phone),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- ============================================================
-- 二、产品模块 (5张表)
-- ============================================================

-- 5. 产品分类表
CREATE TABLE IF NOT EXISTS categories (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    name VARCHAR(50) NOT NULL COMMENT '分类名称',
    icon VARCHAR(255) COMMENT '图标URL',
    bg_color VARCHAR(20) COMMENT '背景色',
    icon_color VARCHAR(20) COMMENT '图标色',
    sort_order INT DEFAULT 0 COMMENT '排序',
    status TINYINT DEFAULT 1 COMMENT '状态(0禁用/1启用)',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_status (status),
    INDEX idx_sort_order (sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='产品分类表';

-- 6. 旅游产品表
CREATE TABLE IF NOT EXISTS products (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    title VARCHAR(100) NOT NULL COMMENT '产品标题',
    subtitle VARCHAR(200) COMMENT '副标题/描述',
    cover_image VARCHAR(255) COMMENT '封面图URL',
    duration VARCHAR(20) COMMENT '行程时长(如3天2晚)',
    original_price DECIMAL(10,2) COMMENT '原价',
    price DECIMAL(10,2) NOT NULL COMMENT '现价',
    stock INT DEFAULT 0 COMMENT '总库存',
    sold_count INT DEFAULT 0 COMMENT '已售数量',
    region_id INT COMMENT '目的地地区ID',
    category_id INT COMMENT '分类ID',
    status TINYINT DEFAULT 1 COMMENT '状态(0下架/1上架)',
    sort_order INT DEFAULT 0 COMMENT '排序权重',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (region_id) REFERENCES regions(id) ON DELETE SET NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL,
    INDEX idx_status (status),
    INDEX idx_price (price),
    INDEX idx_category_id (category_id),
    INDEX idx_region_id (region_id),
    INDEX idx_sort_order (sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='旅游产品表';

-- 7. 产品图片表
CREATE TABLE IF NOT EXISTS product_images (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    product_id INT NOT NULL COMMENT '产品ID',
    image_url VARCHAR(255) NOT NULL COMMENT '图片URL',
    sort_order INT DEFAULT 0 COMMENT '排序',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    INDEX idx_product_id (product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='产品图片表';

-- 8. 产品详情表
CREATE TABLE IF NOT EXISTS product_details (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    product_id INT NOT NULL UNIQUE COMMENT '产品ID(一对一)',
    highlights TEXT COMMENT '产品亮点',
    itinerary TEXT COMMENT '行程安排',
    fee_include TEXT COMMENT '费用包含',
    fee_exclude TEXT COMMENT '费用不含',
    notice TEXT COMMENT '预订须知',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='产品详情表';

-- 9. 产品排期表
CREATE TABLE IF NOT EXISTS product_schedules (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    product_id INT NOT NULL COMMENT '产品ID',
    travel_date DATE NOT NULL COMMENT '出行日期',
    price DECIMAL(10,2) COMMENT '当日价格(为空则使用产品默认价格)',
    stock INT DEFAULT 0 COMMENT '当日库存',
    status TINYINT DEFAULT 1 COMMENT '状态(0不可预订/1可预订)',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    INDEX idx_product_id (product_id),
    INDEX idx_travel_date (travel_date),
    UNIQUE KEY uk_product_date (product_id, travel_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='产品排期表';

-- ============================================================
-- 三、订单模块 (3张表)
-- ============================================================

-- 10. 订单主表
CREATE TABLE IF NOT EXISTS orders (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    order_no VARCHAR(32) NOT NULL UNIQUE COMMENT '订单号',
    user_id INT NOT NULL COMMENT '用户ID',
    product_id INT NOT NULL COMMENT '产品ID',
    schedule_id INT COMMENT '排期ID',
    quantity INT DEFAULT 1 COMMENT '数量',
    unit_price DECIMAL(10,2) NOT NULL COMMENT '下单时单价(快照)',
    total_amount DECIMAL(10,2) NOT NULL COMMENT '总金额',
    status TINYINT DEFAULT 0 COMMENT '状态(0待付款/1待出行/2已完成/3已取消/4退款中/5已退款)',
    cancel_reason VARCHAR(255) COMMENT '取消原因',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (schedule_id) REFERENCES product_schedules(id) ON DELETE SET NULL,
    INDEX idx_order_no (order_no),
    INDEX idx_user_id (user_id),
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单主表';

-- 11. 订单支付表
CREATE TABLE IF NOT EXISTS order_payments (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    order_id INT NOT NULL UNIQUE COMMENT '订单ID(一对一)',
    user_coupon_id INT COMMENT '使用的优惠券ID',
    discount_amount DECIMAL(10,2) DEFAULT 0 COMMENT '优惠金额',
    pay_amount DECIMAL(10,2) NOT NULL COMMENT '实付金额',
    pay_method TINYINT COMMENT '支付方式(1微信/2支付宝)',
    pay_time DATETIME COMMENT '支付时间',
    transaction_id VARCHAR(64) COMMENT '第三方交易号',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    INDEX idx_pay_time (pay_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单支付表';

-- 12. 出行人表
CREATE TABLE IF NOT EXISTS order_travelers (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    order_id INT NOT NULL COMMENT '订单ID',
    name VARCHAR(50) NOT NULL COMMENT '姓名',
    id_card VARCHAR(20) COMMENT '身份证号',
    phone VARCHAR(20) COMMENT '联系电话',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    INDEX idx_order_id (order_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='出行人表';

-- ============================================================
-- 四、内容模块 (3张表)
-- ============================================================

-- 13. 轮播图表
CREATE TABLE IF NOT EXISTS banners (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    title VARCHAR(100) COMMENT '标题',
    image_url VARCHAR(255) NOT NULL COMMENT '图片URL',
    link_type TINYINT DEFAULT 0 COMMENT '链接类型(0无/1产品/2内容/3外链)',
    link_id INT COMMENT '关联ID(产品或内容ID)',
    link_url VARCHAR(255) COMMENT '外链URL',
    position VARCHAR(20) DEFAULT 'home' COMMENT '展示位置(home首页/discover发现)',
    sort_order INT DEFAULT 0 COMMENT '排序',
    status TINYINT DEFAULT 1 COMMENT '状态(0禁用/1启用)',
    start_time DATETIME COMMENT '开始展示时间',
    end_time DATETIME COMMENT '结束展示时间',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_position (position),
    INDEX idx_status (status),
    INDEX idx_sort_order (sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='轮播图表';

-- 14. 内容标签表
CREATE TABLE IF NOT EXISTS post_tags (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    name VARCHAR(20) NOT NULL COMMENT '标签名',
    color VARCHAR(20) COMMENT '标签颜色',
    sort_order INT DEFAULT 0 COMMENT '排序',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    INDEX idx_sort_order (sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='内容标签表';

-- 15. 发现内容表
CREATE TABLE IF NOT EXISTS posts (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    user_id INT COMMENT '作者ID',
    title VARCHAR(200) NOT NULL COMMENT '标题',
    cover_image VARCHAR(255) COMMENT '封面图',
    content TEXT COMMENT '内容',
    tag_id INT COMMENT '标签ID',
    category TINYINT DEFAULT 1 COMMENT '分类(1攻略/2特价)',
    views_count INT DEFAULT 0 COMMENT '浏览数',
    likes_count INT DEFAULT 0 COMMENT '点赞数',
    aspect_ratio VARCHAR(10) COMMENT '封面比例',
    status TINYINT DEFAULT 1 COMMENT '状态(0草稿/1已发布/2已下架)',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (tag_id) REFERENCES post_tags(id) ON DELETE SET NULL,
    INDEX idx_category (category),
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='发现内容表';

-- ============================================================
-- 五、互动模块 (2张表)
-- ============================================================

-- 16. 收藏表
CREATE TABLE IF NOT EXISTS favorites (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    user_id INT NOT NULL COMMENT '用户ID',
    target_type TINYINT NOT NULL COMMENT '类型(1产品/2内容)',
    target_id INT NOT NULL COMMENT '目标ID',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE KEY uk_user_target (user_id, target_type, target_id),
    INDEX idx_user_id (user_id),
    INDEX idx_target (target_type, target_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='收藏表';

-- 17. 点赞表
CREATE TABLE IF NOT EXISTS likes (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    user_id INT NOT NULL COMMENT '用户ID',
    post_id INT NOT NULL COMMENT '内容ID',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '点赞时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
    UNIQUE KEY uk_user_post (user_id, post_id),
    INDEX idx_post_id (post_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='点赞表';

-- ============================================================
-- 六、营销模块 (2张表)
-- ============================================================

-- 18. 优惠券模板表
CREATE TABLE IF NOT EXISTS coupons (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    name VARCHAR(50) NOT NULL COMMENT '优惠券名称',
    type TINYINT NOT NULL COMMENT '类型(1满减/2折扣/3立减)',
    value DECIMAL(10,2) NOT NULL COMMENT '面值或折扣率',
    min_amount DECIMAL(10,2) DEFAULT 0 COMMENT '最低消费门槛',
    total_count INT DEFAULT 0 COMMENT '发放总量(0为不限)',
    remain_count INT DEFAULT 0 COMMENT '剩余数量',
    valid_days INT COMMENT '领取后有效天数',
    start_time DATETIME COMMENT '活动开始时间',
    end_time DATETIME COMMENT '活动结束时间',
    status TINYINT DEFAULT 1 COMMENT '状态(0禁用/1启用)',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='优惠券模板表';

-- 19. 用户优惠券表
CREATE TABLE IF NOT EXISTS user_coupons (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    user_id INT NOT NULL COMMENT '用户ID',
    coupon_id INT NOT NULL COMMENT '优惠券模板ID',
    status TINYINT DEFAULT 0 COMMENT '状态(0未使用/1已使用/2已过期)',
    receive_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '领取时间',
    expire_at DATETIME COMMENT '过期时间',
    used_at DATETIME COMMENT '使用时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (coupon_id) REFERENCES coupons(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_status (status),
    INDEX idx_expire_at (expire_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户优惠券表';

-- 添加order_payments的外键(user_coupons表创建后)
ALTER TABLE order_payments ADD FOREIGN KEY (user_coupon_id) REFERENCES user_coupons(id) ON DELETE SET NULL;

-- ============================================================
-- 七、系统配置模块 (2张表)
-- ============================================================

-- 20. 公司/旅行社信息表
CREATE TABLE IF NOT EXISTS company_info (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    `key` VARCHAR(50) NOT NULL UNIQUE COMMENT '配置键名',
    value TEXT COMMENT '配置值',
    type VARCHAR(20) DEFAULT 'text' COMMENT '值类型(text/image/json)',
    `group` VARCHAR(50) COMMENT '分组(basic/contact/about)',
    sort_order INT DEFAULT 0 COMMENT '排序',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_group (`group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='公司信息配置表';

-- 21. AI客服话术表
CREATE TABLE IF NOT EXISTS ai_replies (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    keywords VARCHAR(255) NOT NULL COMMENT '触发关键词(逗号分隔)',
    question VARCHAR(255) COMMENT '问题示例',
    answer TEXT NOT NULL COMMENT '回答内容',
    category VARCHAR(50) COMMENT '分类(订单/退款/行程/优惠等)',
    priority INT DEFAULT 0 COMMENT '优先级(数值越大越优先)',
    status TINYINT DEFAULT 1 COMMENT '状态(0禁用/1启用)',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_category (category),
    INDEX idx_status (status),
    INDEX idx_priority (priority)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='AI客服话术表';

-- ============================================================
-- 八、媒体资源模块 (2张表)
-- ============================================================

-- 22. 媒体文件夹表
CREATE TABLE IF NOT EXISTS media_folders (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    name VARCHAR(50) NOT NULL COMMENT '文件夹名',
    parent_id INT DEFAULT 0 COMMENT '父级ID(0为根目录)',
    sort_order INT DEFAULT 0 COMMENT '排序',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    INDEX idx_parent_id (parent_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='媒体文件夹表';

-- 23. 媒体资源库表
CREATE TABLE IF NOT EXISTS media_library (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    name VARCHAR(100) COMMENT '文件名',
    url VARCHAR(255) NOT NULL COMMENT '文件URL',
    type TINYINT NOT NULL COMMENT '类型(1图片/2视频/3文档)',
    size INT COMMENT '文件大小(字节)',
    width INT COMMENT '图片宽度',
    height INT COMMENT '图片高度',
    folder_id INT COMMENT '所属文件夹ID',
    uploader_id INT COMMENT '上传者ID',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
    FOREIGN KEY (folder_id) REFERENCES media_folders(id) ON DELETE SET NULL,
    FOREIGN KEY (uploader_id) REFERENCES admin_users(id) ON DELETE SET NULL,
    INDEX idx_folder_id (folder_id),
    INDEX idx_type (type),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='媒体资源库表';

-- ============================================================
-- 九、财务模块 (3张表)
-- ============================================================

-- 24. 交易流水表
CREATE TABLE IF NOT EXISTS transactions (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    transaction_no VARCHAR(32) NOT NULL UNIQUE COMMENT '交易流水号',
    user_id INT NOT NULL COMMENT '用户ID',
    order_id INT COMMENT '关联订单ID(可空)',
    type TINYINT NOT NULL COMMENT '类型(1支付/2退款/3充值/4提现)',
    amount DECIMAL(10,2) NOT NULL COMMENT '交易金额',
    pay_method TINYINT COMMENT '支付方式(1微信/2支付宝/3余额)',
    status TINYINT DEFAULT 0 COMMENT '状态(0处理中/1成功/2失败)',
    third_party_no VARCHAR(64) COMMENT '第三方交易号',
    remark VARCHAR(255) COMMENT '备注',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    completed_at DATETIME COMMENT '完成时间',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE SET NULL,
    INDEX idx_transaction_no (transaction_no),
    INDEX idx_user_id (user_id),
    INDEX idx_order_id (order_id),
    INDEX idx_type (type),
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='交易流水表';

-- 25. 退款记录表
CREATE TABLE IF NOT EXISTS refunds (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    refund_no VARCHAR(32) NOT NULL UNIQUE COMMENT '退款单号',
    order_id INT NOT NULL COMMENT '订单ID',
    transaction_id INT COMMENT '原支付流水ID',
    user_id INT NOT NULL COMMENT '用户ID',
    amount DECIMAL(10,2) NOT NULL COMMENT '退款金额',
    reason VARCHAR(255) COMMENT '退款原因',
    status TINYINT DEFAULT 0 COMMENT '状态(0申请中/1审核通过/2退款中/3已退款/4已拒绝)',
    auditor_id INT COMMENT '审核人ID',
    audit_time DATETIME COMMENT '审核时间',
    audit_remark VARCHAR(255) COMMENT '审核备注',
    refund_time DATETIME COMMENT '退款完成时间',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE SET NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (auditor_id) REFERENCES admin_users(id) ON DELETE SET NULL,
    INDEX idx_refund_no (refund_no),
    INDEX idx_order_id (order_id),
    INDEX idx_user_id (user_id),
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='退款记录表';

-- 26. 账单汇总表
CREATE TABLE IF NOT EXISTS bills (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '主键',
    bill_date DATE NOT NULL UNIQUE COMMENT '账单日期',
    total_income DECIMAL(12,2) DEFAULT 0 COMMENT '总收入',
    total_refund DECIMAL(12,2) DEFAULT 0 COMMENT '总退款',
    total_orders INT DEFAULT 0 COMMENT '订单数',
    total_refund_orders INT DEFAULT 0 COMMENT '退款订单数',
    net_income DECIMAL(12,2) DEFAULT 0 COMMENT '净收入',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '生成时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_bill_date (bill_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='账单汇总表';

-- ============================================================
-- 初始化数据
-- ============================================================

-- 插入默认管理员角色
INSERT INTO admin_roles (name, permissions) VALUES 
('超级管理员', '["*"]'),
('运营人员', '["products", "orders", "posts", "banners"]'),
('客服人员', '["orders", "refunds", "ai_replies"]'),
('财务人员', '["orders", "transactions", "refunds", "bills"]');

-- 插入默认超级管理员 (密码: admin123, 需要在应用中使用bcrypt加密)
INSERT INTO admin_users (username, password, real_name, role_id, status) VALUES 
('admin', '$2b$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW', '超级管理员', 1, 1);

-- 插入默认产品分类
INSERT INTO categories (name, icon, bg_color, icon_color, sort_order) VALUES 
('周边游', '/images/icon_hiking.png', '#fff7ed', '#ea580c', 1),
('穷游', '/images/icon_money.png', '#f0fdf4', '#16a34a', 2),
('露营', '/images/icon_tent.png', '#eff6ff', '#2563eb', 3),
('情侣游', '/images/icon_heart.png', '#fff1f2', '#e11d48', 4),
('拼团', '/images/icon_group.png', '#faf5ff', '#9333ea', 5),
('特价', '/images/icon_ticket.png', '#fffbeb', '#d97706', 6);

-- 插入默认内容标签
INSERT INTO post_tags (name, color, sort_order) VALUES 
('穷游', 'rgba(0,0,0,0.3)', 1),
('拼团', '#f97316', 2),
('周末', '#22c55e', 3),
('特价', '#ef4444', 4),
('攻略', '#3b82f6', 5);

-- 插入公司基本信息
INSERT INTO company_info (`key`, value, type, `group`, sort_order) VALUES 
('company_name', '趣旅行', 'text', 'basic', 1),
('slogan', '让每一次旅行都充满惊喜', 'text', 'basic', 2),
('logo', '/images/logo.png', 'image', 'basic', 3),
('phone', '400-888-6666', 'text', 'contact', 1),
('email', 'contact@qulvxing.com', 'text', 'contact', 2),
('address', '浙江省杭州市西湖区文三路478号华星科技大厦15楼', 'text', 'contact', 3),
('wechat', 'qulvxing_service', 'text', 'contact', 4),
('mission', '为大学生提供高性价比、安全可靠的旅行服务', 'text', 'about', 1),
('vision', '成为中国最受大学生信赖的旅行平台', 'text', 'about', 2),
('founded_year', '2020', 'text', 'about', 3),
('founded_month', '06', 'text', 'about', 4);

-- 插入AI客服默认话术
INSERT INTO ai_replies (keywords, question, answer, category, priority) VALUES 
('退款,退钱,取消订单,不想去了', '如何申请退款？', '您可以在"我的订单"中找到对应订单，点击"申请退款"按钮。退款将在1-3个工作日内原路返回。如有疑问，请联系客服400-888-6666。', '退款', 100),
('优惠券,折扣,满减,优惠', '有什么优惠活动？', '目前我们有以下优惠活动：\n1. 新用户注册送50元优惠券\n2. 满500减50活动\n3. 拼团享8折优惠\n更多优惠请关注首页轮播图和"我的-优惠券"页面。', '优惠', 90),
('行程,出发,集合,时间', '出发时间是几点？', '具体出发时间会在出行前1天以短信形式通知您，请保持手机畅通。一般集合时间为早上7:00-8:00，具体以通知为准。', '行程', 80),
('付款,支付,怎么付', '如何付款？', '我们支持微信支付和支付宝支付。选择好产品和出行日期后，点击"立即预订"即可进入支付页面。', '支付', 70),
('发票,开票,报销', '可以开发票吗？', '可以的！订单完成后，您可以在"我的订单"中申请电子发票，发票将在3个工作日内发送到您的邮箱。', '发票', 60),
('客服,人工,电话', '怎么联系人工客服？', '您可以通过以下方式联系我们：\n1. 客服热线：400-888-6666（9:00-21:00）\n2. 微信客服：qulvxing_service\n3. 邮箱：contact@qulvxing.com', '客服', 50);

-- 插入示例地区数据
INSERT INTO regions (name, parent_id, level, is_hot, sort_order) VALUES 
('浙江省', 0, 1, 0, 1),
('重庆市', 0, 1, 1, 2),
('湖南省', 0, 1, 1, 3),
('四川省', 0, 1, 1, 4),
('云南省', 0, 1, 1, 5),
('西藏自治区', 0, 1, 1, 6);

INSERT INTO regions (name, parent_id, level, is_hot, sort_order) VALUES 
('杭州市', 1, 2, 1, 1),
('重庆市', 2, 2, 1, 1),
('张家界市', 3, 2, 1, 1),
('成都市', 4, 2, 1, 1),
('大理白族自治州', 5, 2, 1, 1),
('拉萨市', 6, 2, 1, 1);

-- 插入默认媒体文件夹
INSERT INTO media_folders (name, parent_id, sort_order) VALUES 
('产品图片', 0, 1),
('轮播图', 0, 2),
('用户头像', 0, 3),
('攻略封面', 0, 4),
('系统图标', 0, 5);

-- ============================================================
-- 完成提示
-- ============================================================
SELECT '数据库创建完成！共创建25张表，并插入了初始化数据。' AS message;
