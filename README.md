# loupedeck-ops
> このプロジェクトは macOS ホームディレクトリ直下（`~/loupedeck-ops`）に配置して運用することを前提としています。
> `~/Documents` 配下に作成するとLoupedeckや`.app`連携で正しく動作しない可能性があります。

このリポジトリは、Loupedeck ボタン操作から呼び出される  
小型スクリプト群（1操作 = 1スクリプト）を管理する構成です。

## 📁 ディレクトリ構成

```
loupedeck-ops/
├── scripts/                # 機能別スクリプト群
│   ├── input/              # 音声入力、IME切替、ESC送信など
│   ├── media/              # 再生・停止・送り・戻し
│   ├── menu/               # メニューバー関連操作
│   ├── edit/               # Undo・Redo・Copy・Paste 等
│   ├── window/             # ウィンドウ切替、最小化、整列など
│   └── util/               # スクショ、日時挿入、通知など
├── docs/                   # workspace設計メモ等
├── logs/                   # スクリプト実行ログ（任意）
├── assets/button_labels/   # ボタン用アイコン（任意）
└── .ldpk/（Git管理対象外） # Loupedeck GUIによるプロファイル設定
```

## ✅ スクリプト設計方針

- すべてのスクリプトは「1操作 = 1ファイル」
- 状態管理（トグル等）はLoupedeck本体GUIで行う
- `.ldpk/` はGitに含めない（`.gitignore`で除外）

## 使用例（今後追加予定）

- `scripts/input/voice_input_toggle.sh`：音声入力を開始／停止
- `scripts/edit/undo.sh`：Undo操作

## 🧭 Loupedeck連携：スクリプト実行フレームワーク

本プロジェクトは、macOS上で **Loupedeckボタン操作により自動的に補助操作を実行する** ことを目的とした汎用スクリプト構成です。

### 📁 ディレクトリ構成（概要）

\`\`\`
loupedeck-ops/
├── scripts/
│   ├── ops/                            # 機能単位の操作スクリプト群（例：音声入力）
│   │   ├── start_dictation.sh         # 音声入力を開始
│   │   └── stop_dictation.sh          # 音声入力を停止
│   ├── dispatch.sh                    # 操作名に応じて上記スクリプトを実行
│   └── util/
├── LoupedeckApps/                     # Loupedeckから起動するラッパー.app配置場所
│   └── DispatchApp.app/              # dispatch.sh を呼び出す実行ラッパー
├── logs/
│   └── dispatch.log                   # 実行ログ（オプション）
└── README.md
\`\`\`

---

### 🚀 使用手順

#### 1. 操作スクリプトの構成例

\`scripts/ops/start_dictation.sh\`:

\`\`\`bash
#!/bin/bash
osascript <<APPLESCRIPT
tell application "System Events"
	tell process "SystemUIServer"
		set frontmost to true
		click menu item "音声入力を開始" of menu 1 of menu bar item "編集" of menu bar 1
	end tell
end tell
APPLESCRIPT
\`\`\`

\`scripts/ops/stop_dictation.sh\`:

\`\`\`bash
#!/bin/bash
osascript <<APPLESCRIPT
tell application "System Events"
	tell process "SystemUIServer"
		set frontmost to true
		click menu item "音声入力を停止" of menu 1 of menu bar item "編集" of menu bar 1
	end tell
end tell
APPLESCRIPT
\`\`\`

#### 2. dispatch.sh の呼び出し形式

\`\`\`bash
./scripts/dispatch.sh start_dictation
./scripts/dispatch.sh stop_dictation
\`\`\`

#### 3. Loupedeckとの連携方法

Loupedeckアプリ上では以下のように指定します：

\`\`\`
/Users/yuma/LoupedeckApps/DispatchApp.app/Contents/MacOS/DispatchApp
\`\`\`

このラッパー .app の中では、次のように dispatch.sh を呼び出します：

\`\`\`bash
#!/bin/bash
/Users/yuma/loupedeck-ops/scripts/dispatch.sh start_dictation
\`\`\`

別の操作に切り替えたい場合は、\`start_dictation\` の部分を \`stop_dictation\` に変更すればOKです。

---

### 🗂 登録済みスクリプト一覧

| コマンド名           | 機能内容             |
|----------------------|----------------------|
| \`start_dictation\`    | 音声入力を開始       |
| \`stop_dictation\`     | 音声入力を停止       |
