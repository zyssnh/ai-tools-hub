# AI Tools Docker

浏览器可访问的多 AI 编程助手聚合环境。

## 包含工具

| 工具 | 类型 | 访问路径 | 端口 |
|------|------|----------|------|
| **OpenClaw** | AI Agent 网关 + Control UI | `/openclaw/` | 18789 |
| **Hermes Agent** | AI Agent + Dashboard | `/hermes/` | 9119 |
| **OpenCode** | AI Coding Agent Web UI | `/opencode/` | 4096 |
| **Claude Code** | Anthropic CLI | `/terminal/` → tmux | 7681 |
| **MiMo Code** | Xiaomi CLI | `/terminal/` → tmux | 7681 |
| **Kimi Code** | Moonshot CLI | `/terminal/` → tmux | 7681 |
| **Pi** | Minimal CLI Agent | `/terminal/` → tmux | 7681 |

## 快速开始

```bash
# 1. 配置环境变量
cp .env.example .env
# 编辑 .env 填入 API keys

# 2. 生成安全密码
./scripts/generate-passwords.sh >> .env

# 3. 启动全部服务
docker compose up -d

# 4. 浏览器访问
# http://localhost — 导航页
# http://localhost/openclaw/ — OpenClaw
# http://localhost/hermes/ — Hermes
# http://localhost/opencode/ — OpenCode
# http://localhost/terminal/ — 终端（含所有 CLI 工具）
```

## 目录结构

```
docker/
├── docker-compose.yml        # 服务编排
├── .env                      # 环境变量（需自行创建）
├── nginx/                    # 反向代理 + 导航页
├── cli-tools/                # CLI 工具容器（ttyd + tmux）
├── opencode/                 # OpenCode 配置
├── openclaw/                 # OpenClaw 配置
├── volumes/                  # 持久化数据
└── scripts/                  # 辅助脚本
```

## 依赖

- Docker >= 20.10
- Docker Compose >= 2.0
