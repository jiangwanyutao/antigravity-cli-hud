# antigravity-cli-hud

English | [简体中文](README.zh-CN.md)

[![Version](https://img.shields.io/badge/version-1.1.0-blue.svg)](plugin.json)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20macOS%20%7C%20Linux-lightgrey.svg)]()

An authentic **[claude-hud](https://github.com/jarrodwatts/claude-hud) inspired** multi-line Heads-Up Display (HUD) and statusline plugin for the **Google Antigravity CLI (`agy`)**, **Antigravity IDE**, and **Antigravity 2.0 Desktop**.

It renders directly below your terminal input box—no `tmux` or separate windows required—providing real-time visibility into your active AI model, full workspace path, zsh-style Git branch, context window consumption, live token generation speed, 5-hour/weekly/Argon rate limits, and real-time session tool execution tracking with **zero LLM token overhead**.

---

## 📸 Preview

```text
[Gemini 3.8 Flash] │ /workspace/project git:(main*) │ Context [░░░░░░░░░░] 6.2% (65.0k/1.0M) │ ⚡ 72.0 t/s
5h Limit [█████████░] 96% (4h 20m) │ Argon [███████░░░] 79% (5d 17h) │ Weekly [████████░░] 85% (5d 17h)
● Idle │ ✓ run_command ×8 │ ✓ read_file ×5 │ ✓ write_file ×2 │ ⑂ 0 │ ⚙ 0
```

### English (`us`)
![antigravity-cli-hud English Preview](docs/images/agy-hud-en.svg)

### Simplified Chinese (`zh-cn`)
![antigravity-cli-hud Chinese Preview](docs/images/agy-hud-zh.svg)

---

## ✨ Key Features

- **Authentic `jarrodwatts/claude-hud` Terminal Aesthetics**:
  - **Row 1 — Model, Full Path, Context & Token Speed**: Bracketed brand model `[Gemini 3.8 Flash]`, full workspace path with zsh-style Git branch `git:(main*)`, unified context progress bar with token count `Context [░░░░░░░░░░] 6.2% (65.0k/1.0M)`, and real-time token speed `⚡ 72.0 t/s`.
  - **Row 2 — Multi-Pool Quotas with Inline Countdown**: 5-hour rolling quota with inline reset timer `5h Limit [█████████░] 96% (4h 20m)`, dedicated **Gemini 4 Argon** quota bar, and weekly quota bar.
  - **Row 3 — Live Session Tool Activity & Telemetry**: Status indicator `● Idle`, live tool execution stats tailed from the JSONL session transcript `✓ run_command ×8 │ ✓ read_file ×5`, running subagents, and background tasks.
- **Modern Developer Icon Themes (No Tacky AI Emojis)**:
  - Default Lucide-inspired minimalist developer glyphs (`✦`, `★`, `◈`, `⚡`, `◷`, `⎇`, `●`, `⑂`, `⚙`).
  - Optional native **Nerd Fonts** support (``, `󰚩`, `󰍛`, `󱐋`, etc.).
- **24-Bit Four-Tier Dynamic Color Coding**:
  - `100% – 75%`: Blue (`#57caff`)
  - `74% – 50%`: Green (`#5cdb6d`)
  - `49% – 25%`: Yellow (`#ffd427`)
  - `24% – 0%`: Red/Pink (`#ff7daf`)
- **Zero Token Overhead**: Polls the local Antigravity Language Server RPC endpoint directly in the background with smart disk caching.
- **Multi-Language Support**: Supports English (`us`), Simplified Chinese (`zh-cn`), Traditional Chinese (`zh-tw`), and Japanese (`jp`) with instant hot-reloading.
- **Cross-Platform**: Pure Node.js (`.mjs`) implementation supporting Windows, macOS, and Linux.

---

## 🚀 Installation

### Prerequisites
- **Node.js** (v18+ required)
- **Git** (optional, for branch and dirty state tracking)

### Option 1: Install via Antigravity Plugin Manager

```bash
agy plugin install https://github.com/jiangwanyutao/antigravity-cli-hud
```

### Option 2: One-Click Global Install (Windows PowerShell)

Clone the repository and run the included installer script:

```powershell
git clone https://github.com/jiangwanyutao/antigravity-cli-hud.git
cd antigravity-cli-hud
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

### Option 3: Bind Directly Inside `agy` CLI

Inside an active `agy` CLI session, run:

```text
/statusline node /absolute/path/to/antigravity-cli-hud/skills/agy-hud/scripts/statusline-quota.mjs
```

> **Note**: When enabling the statusline hook for the first time, restart `agy` CLI (exit and reopen) to load the hook process. Subsequent changes to `settings.json` hot-reload automatically without restarts!

---

## ⚙️ Customization

You can configure options in `~/.gemini/antigravity-cli/settings.json` (or `<workspace>/.gemini/settings.json`):

```json
{
  "ui": {
    "language": "us",
    "footer": {
      "layout": "claude-hud",
      "iconTheme": "lucide",
      "barLength": 10
    }
  }
}
```

### Configuration Reference:

| Setting | Type | Default | Options / Description |
| :--- | :--- | :--- | :--- |
| `ui.language` | string | `"us"` | `"us"` (English), `"zh-cn"` (Simplified Chinese), `"zh-tw"` (Traditional Chinese), `"jp"` (Japanese) |
| `ui.footer.layout` | string | `"claude-hud"` | `"claude-hud"` (authentic 3-line layout) or `"modular"` (custom item assembler) |
| `ui.footer.iconTheme` | string | `"lucide"` | `"lucide"` (minimalist symbols), `"nerd"` (Nerd Fonts glyphs), `"classic-emoji"` |
| `ui.footer.barLength` | number | `10` | Progress bar blocks count (1 to 30) |

---

## 🙏 Credits & Acknowledgements

- Visual design and live tool tracking inspired by [jarrodwatts/claude-hud](https://github.com/jarrodwatts/claude-hud).
- Core quota telemetry and statusline hook mechanisms based on [AndyAWD/antigravity-cli-statusline](https://github.com/AndyAWD/antigravity-cli-statusline) (MIT License).

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).
