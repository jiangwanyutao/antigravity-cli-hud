# agy-hud 一键全局安装脚本 (Windows PowerShell)
$ErrorActionPreference = "Stop"

$HomeDir = $env:USERPROFILE
$HooksDir = Join-Path $HomeDir ".gemini\antigravity-cli\hooks"
$CliSettingsPath = Join-Path $HomeDir ".gemini\antigravity-cli\settings.json"
$GlobalSettingsPath = Join-Path $HomeDir ".gemini\settings.json"
$TrustedHooksPath = Join-Path $HomeDir ".gemini\trusted_hooks.json"

New-Item -ItemType Directory -Force -Path $HooksDir | Out-Null

$SrcHooksDir = Join-Path $PSScriptRoot "..\..\..\.gemini\hooks"
if (-not (Test-Path (Join-Path $SrcHooksDir "statusline-quota.mjs"))) {
    $SrcHooksDir = Join-Path $PSScriptRoot "skills\agy-hud\scripts"
}

Copy-Item -Path (Join-Path $SrcHooksDir "statusline-quota.mjs") -Destination (Join-Path $HooksDir "statusline-quota.mjs") -Force
Copy-Item -Path (Join-Path $SrcHooksDir "fetch-local-quota.mjs") -Destination (Join-Path $HooksDir "fetch-local-quota.mjs") -Force

$TargetMjs = Join-Path $HooksDir "statusline-quota.mjs"
$StatusLineCmd = "node $TargetMjs"

node -e "
const fs = require('fs');
const paths = [process.argv[1], process.argv[2]];
const cmd = process.argv[3];
const footer = {
  labelStyle: 'text',
  items: [
    'model-name', 'plan-tier', 'context-used', 'context-used-bar', 'token-count', 'token-speed', 'n',
    'quota', 'quota-bar', 'quota-reset-countdown', 'quota-argon', 'quota-argon-bar', 'quota-weekly', 'quota-weekly-bar', 'n',
    'project-path', 'git-branch', 'vcs-dirty', 'agent-state', 'subagents', 'background-tasks', 'pending-input', 'tool-confirmation'
  ],
  itemStyles: {
    'model-name': 'emoji', 'plan-tier': 'emoji', 'token-count': 'emoji', 'token-speed': 'emoji',
    'quota-reset-countdown': 'emoji', 'project-path': 'emoji', 'git-branch': 'emoji', 'vcs-dirty': 'emoji'
  }
};
for (const p of paths) {
  let obj = {};
  try { obj = JSON.parse(fs.readFileSync(p, 'utf8').replace(/^\uFEFF/, '')); } catch (e) {}
  if (!obj.ui) obj.ui = {};
  obj.ui.language = 'zh-cn';
  obj.ui.footer = footer;
  obj.statusLine = { enabled: true, type: 'command', command: cmd };
  fs.writeFileSync(p, JSON.stringify(obj, null, 2), 'utf8');
}
const thPath = process.argv[4];
let th = {};
try { th = JSON.parse(fs.readFileSync(thPath, 'utf8').replace(/^\uFEFF/, '')); } catch (e) {}
if (!th['*']) th['*'] = [];
const entry = 'statusLine:' + cmd;
if (!th['*'].includes(entry)) th['*'].push(entry);
fs.writeFileSync(thPath, JSON.stringify(th, null, 2), 'utf8');
" "$CliSettingsPath" "$GlobalSettingsPath" "$StatusLineCmd" "$TrustedHooksPath"

Write-Host "✅ agy-hud (claude-hud 风格状态栏) 已成功全局安装！请重启一次 agy CLI 使其生效。" -ForegroundColor Green
