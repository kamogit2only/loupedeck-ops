#!/bin/bash

YAML_FILE="docs/promptbook.yaml"

# 全カテゴリを順に処理
yq eval 'keys | .[]' "$YAML_FILE" | while read -r category; do
  count=$(yq eval ".${category} | length" "$YAML_FILE")

  if [ "$count" -eq 0 ]; then
    continue
  fi

  for i in $(seq 0 $((count - 1))); do
    cmd=$(yq eval ".${category}[$i].command" "$YAML_FILE")
    desc=$(yq eval ".${category}[$i].description" "$YAML_FILE")

    # 対象スクリプトを探す
    file=$(find scripts -type f -name "${cmd}.sh" | head -n 1)
    [[ -z "$file" ]] && continue

    if grep -q "# command: $cmd" "$file"; then
      echo "スキップ済: $file"
      continue
    fi

    tmpfile="${file}.tmp"
    {
      echo "#!/bin/bash"
      echo "# command: $cmd"
      echo "# description: $desc"
      echo ""
      grep -v '^#!/bin/bash' "$file"
    } > "$tmpfile"

    mv "$tmpfile" "$file"
    chmod +x "$file"
    echo "挿入完了: $file"
  done
done
