# Loupedeck 操作一覧（2025-05-16 更新）

## 利用可能なスクリプト（scripts/menu/）

| コマンド名           | 内容                     |
|----------------------|--------------------------|
| start_dictation      | 音声入力を開始する       |
| stop_dictation       | 音声入力を停止する       |
| composition_tools    | 作文ツールを表示する     |
| compose              | 作文メニューから作文実行 |

## 使用例

# コマンドラインからの実行
./scripts/dispatch.sh start_dictation
./scripts/dispatch.sh stop_dictation
./scripts/dispatch.sh composition_tools
./scripts/dispatch.sh compose

# Loupedeck `.app` から実行する場合の指定例:
/Users/yuma/loupedeck-ops/scripts/dispatch.sh start_dictation
