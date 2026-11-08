# antigravity-cli-hud

[English](README.md) | 简体中文

[![Version](https://img.shields.io/badge/version-1.1.0-blue.svg)](plugin.json)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)]()

一款复刻 **[claude-hud](https://github.com/jarrodwatts/claude-hud)** 视觉风格的 **Google Antigravity CLI (`agy`)**、**Antigravity IDE** 与 **Antigravity 2.0 桌面端**多行状态栏（HUD）插件。

它直接渲染在终端输入框正下方（无需 `tmux` 或额外分屏），以**零额外 Token 消耗**实时展示当前 AI 模型、上下文窗口（Context Window）进度条、5 小时 / 每周 / Gemini 4 Argon 专属配额进度条、Git 分支状态，以及正在运行的子代理与后台任务状态。

---

## 📸 界面截图

### 简体中文 (`zh-cn`)
![antigravity-cli-hud 中文预览](docs/images/agy-hud-zh.svg)

### English (`us`)
![antigravity-cli-hud 英文预览](docs/images/agy-hud-en.svg)

---

## ✨ 核心特性

- **原生深度复刻 `jarrodwatts/claude-hud` 终端美学**：
  - **第 1 行 — 模型、完整路径、上下文与输出速率**：中括号专属品牌模型 `[Gemini 3.8 Flash]`、工作区完整路径与 Zsh 风格 Git 分支 `git:(main*)`、一体化上下文进度条 `Context [░░░░░░░░░░] 6.2% (65.0k/1.0M)`、实时 Token 生成速度 `⚡ 72.0 t/s`。
  - **第 2 行 — 多维实时配额池与倒计时**：5 小时滚动配额 `5h可用 [█████████░] 96% (4h 20m)`、**Gemini 4 Argon** 专属配额进度条、7 日周配额进度条。
  - **第 3 行 — 会话工具动态追踪与代理状态**：状态指示灯 `● 闲置`、实时解析 Tail 会话日志的工具调用频次 `✓ run_command ×8 │ ✓ read_file ×5`、子代理与后台任务计数。
  - **第 2 行 — 多维实时配额池**：5 小时滚动配额百分比 + 进度条 + 重置倒计时、**Gemini 4 Argon** 专属配额进度条、7 日周配额进度条。
  - **第 3 行 — 工作区、Git 与代理状态**：当前项目目录名、Git 分支与未提交变更状态、Agent 实时状态（闲置 / 思考中 / 执行中 / 调用工具）、活跃子代理数、后台任务数、输入队列与工具待确认提醒。
- **24-Bit 四级动态色彩预警**：
  - `100% – 75%`：蓝色 (`#57caff`)
  - `74% – 50%`：绿色 (`#5cdb6d`)
  - `49% – 25%`：黄色 (`#ffd427`)
  - `24% – 0%`：粉红/红色 (`#ff7daf`)
- **零 Token 消耗**：后台直接连接本地 Antigravity Language Server RPC 接口获取实时配额，并具备智能磁盘缓存。
- **多语言切换**：支持简体中文 (`zh-cn`)、英文 (`us`)、繁体中文 (`zh-tw`) 与日文 (`jp`)，支持配置热更新（Hot Reload）。
- **跨平台兼容**：纯 Node.js (`.mjs`) 实现，原生支持 Windows、macOS 和 Linux。

---

## 🚀 安装指南

### 环境要求
- **Node.js**（v18 及以上）
- **Git**（可选，用于显示分支与未提交状态）

### 方式一：通过 Antigravity 插件管理器安装

```bash
agy plugin install https://github.com/jiangwanyutao/antigravity-cli-hud
```

### 方式二：Windows PowerShell 一键全局安装

克隆仓库并执行内置的一键安装脚本：

```powershell
git clone https://github.com/jiangwanyutao/antigravity-cli-hud.git
cd antigravity-cli-hud
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

### 方式三：在 `agy` CLI 中直接绑定

在 `agy` 交互式终端中输入：

```text
/statusline node /绝对路径/antigravity-cli-hud/skills/agy-hud/scripts/statusline-quota.mjs
```

> **提示**：首次启用状态栏挂钩（Hook）时，请退出并重新打开一次 `agy` CLI 以加载挂钩进程。启用后对 `settings.json` 的任何布局或语言修改都会**立即热更新生效**，无需重启！

---

## ⚙️ 自定义配置

你可以在 `~/.gemini/antigravity-cli/settings.json`（或项目工作区的 `.gemini/settings.json`）中自由调整语言、进度条长度、文字/Emoji 样式以及换行排版：

```json
{
  "ui": {
    "language": "zh-cn",
    "footer": {
      "labelStyle": "text",
      "barLength": 10,
      "items": [
        "model-name",
        "plan-tier",
        "context-used",
        "context-used-bar",
        "token-count",
        "n",
        "quota",
        "quota-bar",
        "quota-reset-countdown",
        "quota-argon",
        "quota-argon-bar",
        "quota-weekly",
        "quota-weekly-bar",
        "n",
        "project-path",
        "git-branch",
        "vcs-dirty",
        "agent-state",
        "subagents",
        "background-tasks",
        "pending-input",
        "tool-confirmation"
      ],
      "itemStyles": {
        "model-name": "emoji",
        "plan-tier": "emoji",
        "token-count": "emoji",
        "quota-reset-countdown": "emoji",
        "project-path": "emoji",
        "git-branch": "emoji",
        "vcs-dirty": "emoji"
      }
    }
  }
}
```

- 将 `"language"` 设为 `"zh-cn"`（简体中文）、`"us"`（英文）、`"zh-tw"`（繁体中文）或 `"jp"`（日文）即可实时切换语言。
- 在 `"items"` 数组中插入 `"n"` 代表强制换行。

---

## 🙏 致谢

- 视觉排版灵感源自 [jarrodwatts/claude-hud](https://github.com/jarrodwatts/claude-hud)。
- 核心配额采集与状态栏渲染引擎基于 [AndyAWD/antigravity-cli-statusline](https://github.com/AndyAWD/antigravity-cli-statusline)（MIT 协议）构建。

---

## 📄 开源协议

本项目基于 [MIT License](LICENSE) 开源。
