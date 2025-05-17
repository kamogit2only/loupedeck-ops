[ファイル削除]  
ファイル `scripts/menu/toggle_dictation.sh` を削除しました。

[ファイル修正]  
`docs/promptbook.yaml` から以下のエントリを削除しました。

```yaml
  - command: toggle_dictation
    description: 音声入力をトグルで開始／停止する
```

[ファイル修正]  
`scripts/util/create_app_wrapper.sh` 内で `toggle_dictation` を `.app` 化している処理を削除しました。  

---

# docs/promptbook.yaml

```yaml
# (省略)

# 以下のエントリを削除しました
#   - command: toggle_dictation
#     description: 音声入力をトグルで開始／停止する

# (省略)
```

# scripts/util/create_app_wrapper.sh

```bash
#!/bin/bash

# (省略)

# toggle_dictation を .app 化する処理を削除しました

# (省略)
```