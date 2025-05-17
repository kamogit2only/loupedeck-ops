# Makefile for loupedeck-ops project

.PHONY: all md readme apps clean

# 各自動生成スクリプト
UTIL_DIR = scripts/util
PROMPTBOOK = $(UTIL_DIR)/update_promptbook.sh
README = $(UTIL_DIR)/update_readme.sh
APPGEN = $(UTIL_DIR)/create_app_wrapper.sh

# Markdown生成
md:
	@echo "=== Generating promptbook.md ==="
	@$(PROMPTBOOK)

# README生成
readme:
	@echo "=== Generating README.md ==="
	@$(README)

# .app生成
apps:
	@echo "=== Generating .app launchers ==="
	@$(APPGEN)

# 全自動（md + readme + apps）
all: md readme apps

# 一時ファイルや生成物を消す（必要に応じて）
clean:
	rm -f promptbook.md README.md
	rm -rf apps/*.app

# メタデータ挿入（YAML → .sh）
meta:
	@echo "=== Inserting metadata comments into .sh files ==="
	@scripts/util/inject_metadata.sh

# 新規スクリプト・YAML登録
new:
	@if [ -z "$(cmd)" ] || [ -z "$(desc)" ] || [ -z "$(cat)" ]; then \
		echo "使い方: make new cmd=xxx desc='説明' cat=menu"; \
		exit 1; \
	fi
	@scripts/util/create_from_template.sh $(cmd) "$(desc)" $(cat)

	clean_apps:
	@echo "=== Removing all .app launchers ==="
	rm -rf ./apps/*.app