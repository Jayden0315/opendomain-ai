# OpenDomain AI 架构设计（MVP版）

## 整体分层架构
1.  基础架构层：Python + FastAPI + PostgreSQL + Redis
2.  AI核心层：DeepSeek 开源大模型 + LangChain
3.  私域对接层：企微开放API
4.  功能支撑层：用户标签、AI客服、内容生成
5.  部署与生态层：Docker + Docker Compose

## 后续迭代方向
-  支持多开源大模型对接（Qwen、ChatGLM）
-  插件化架构改造，支持多私域平台对接
