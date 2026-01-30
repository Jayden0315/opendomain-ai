#!/bin/bash
set -e

# 等待PostgreSQL启动
直到pg_isready-Uopendomain-dopendomain_db;执行
  echo "等待PostgreSQL启动..."
睡眠2
done

# 连接数据库并创建表
psql -U opendomain -d opendomain_db << EOF
-- 客户表（脱敏存储敏感信息）
CREATE TABLE IF NOT EXISTS customers (
id 序列主键,

    wecom_name VARCHAR(128) ENCRYPTED,          -- 企微昵称（加密）
    phone VARCHAR(32) ENCRYPTED,                -- 手机号（加密）
    tags JSONB DEFAULT '[]'::JSONB,             -- 客户标签
    create_time TIMESTAMP DEFAULT NOW(),
    update_time TIMESTAMP DEFAULT NOW()
);

-- 对话记录表
创建表 IF NOT EXISTS 对话 (
id 序列主键,
客户ID 整数 参考 customers(id),
    question TEXT NOT NULL,                     -- 用户问题
    answer TEXT NOT NULL,                       -- AI回答
    llm_model VARCHAR(64) NOT NULL,             -- 使用的大模型
创建时间 时间戳 默认为当前时间
);

-- 操作审计日志表
创建表 IF NOT EXISTS 审计日志 (
id 序列主键,
    operator VARCHAR(64) NOT NULL,              -- 操作人（开发者/系统）
    operation VARCHAR(64) NOT NULL,             -- 操作类型（AI调用/客户修改/配置变更）
    content JSONB NOT NULL,                     -- 操作内容
    ip VARCHAR(32),                             -- 操作IP
创建时间 时间戳 默认为当前时间
);

-- 敏感词表
创建表如果不存在敏感词（
id 序列主键,
word VARCHAR(64) 唯一 不为空, -- 敏感词
category VARCHAR(32) 默认 'default', -- 分类（广告/违规/隐私）
创建时间 时间戳 默认为当前时间
);

-- 创建索引优化查询
创建索引 IF NOT EXISTS idx_customers_wecom_user_id 以在 customers 表上基于 wecom_user_id；
创建索引 IF NOT EXISTS idx_conversations_customer_id 以在 conversations 表上基于 customer_id；
创建索引 IF NOT EXISTS idx_audit_logs_operation，以在 audit_logs 表的 operation 列上建立；

-- 插入基础敏感词（示例）
插入敏感词（词，类别）值
('虚假宣传', '违规'),
('极限词', '广告'),
('手机号', '隐私')
冲突时（单词）不执行任何操作；

EOF

echo "✅ 数据库初始化完成！"
