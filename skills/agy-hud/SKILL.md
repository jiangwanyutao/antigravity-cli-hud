---
name: agy-hud
description: 配置或切换 claude-hud 风格的 Antigravity CLI 底部多行状态栏（显示模型、上下文进度条、5小时/周/Argon额度进度条、Git状态与子代理/后台任务状态）。
---

# agy-hud 状态栏技能

当用户希望调整 `agy-hud` 状态栏布局、语言或显示指标时，直接修改工作区 `.gemini/settings.json` 中的 `ui.footer` 配置即可实时热更新（Hot Reload）。

## 默认 `claude-hud` 三行布局配置

```json
{
  "ui": {
    "language": "zh-cn",
    "footer": {
      "labelStyle": "text",
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
