# OpenDomain AI
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub Stars](https://img.shields.io/github/stars/{luka515}/opendomain-ai.svg?style=social)](https://github.com/{luka515}/opendomain-ai)
[![GitHub Forks](https://img.shields.io/github/forks/{luka515}/opendomain-ai.svg?style=social)](https://github.com/{luka515}/opendomain-ai)

### 一款**轻量化、可扩展、合规化**的开源AI+私域运营框架
聚焦「企微私域+大模型AI」核心场景，为中小团队/开发者提供低门槛的AI私域工具开发底座，实现**技术普惠、社区共建**。

## 🚀 核心价值
✅ **轻量化**：Docker一键部署，不依赖重型商业组件，30分钟上手  
✅ **高兼容**：原生支持DeepSeek/Qwen/ChatGLM开源大模型，后续对接多私域平台  
✅ **可扩展**：插件化架构设计，预留多场景扩展接口，二次开发成本低  
✅ **合规化**：内置私域运营合规工具，适配最新数据隐私/AI内容标注规范  
✅ **社区共建**：全程开源，接受开发者PR/Issue，一起打造实用的AI+私域框架

## 🏗️ 项目架构（MVP版）
```mermaid
graph TD
    A[企微用户] --> B[企微开放API]
    B --> C[OpenDomain AI 后端<br/>Python+FastAPI]
    C --> D[AI核心层<br/>DeepSeek+LangChain]
    C --> E[数据层<br/>PostgreSQL+Redis]
    D --> C
    C --> F[前端管理后台<br/>Vue3+Element Plus]
    G[开发者] --> H[二次开发/插件开发]
    H --> C
