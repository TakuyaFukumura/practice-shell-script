#!/bin/bash

# TODOリストを管理するシェルスクリプト
# 使用方法:
#   ./todo.sh add タスク内容   # タスクを追加
#   ./todo.sh list           # タスク一覧を表示
#   ./todo.sh del 番号       # 指定番号のタスクを削除

TODO_FILE="${TODO_FILE:-storage/todo.txt}"

case "$1" in
  add)
    shift # タスク内容にスペースが含まれていることを想定している
    echo "$*" >> "$TODO_FILE"
    echo "追加しました。内容:「$*」"
    ;;
  list)
    if [ -s "$TODO_FILE" ]; then # ファイルの存在かつサイズが0でないかを判定
      nl -w2 -s'. ' "$TODO_FILE" # 幅2桁で行番号を付けてファイル内容を表示
    else
      echo "TODOはありません。"
    fi
    ;;
  del)
    if [ -z "$2" ]; then # 引数の空チェック
      echo "削除する番号を指定してください。"
      exit 1
    fi

    if [[ ! "$2" =~ ^[1-9][0-9]*$ ]]; then
        echo "削除する番号は1以上の整数で指定してください。"
        exit 1
    fi

    total_lines=$(wc -l < "$TODO_FILE") # ファイル内の行数を取得
    if [ "$2" -gt "$total_lines" ]; then
        echo "指定された番号は範囲外です。ファイルには $total_lines 行しかありません。"
        exit 1
    fi

    sed -i "${2}d" "$TODO_FILE"
    echo "削除しました。"
    ;;
  *)
    echo "使い方: $0 {add タスク内容 | list | del 番号}"
    exit 1
    ;;
esac
