# loupedeck-ops

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
