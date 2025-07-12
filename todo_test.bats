#!/usr/bin/env bats

# このスクリプトはBatsを使用して、todo.shの機能をテストします。
# 実行方法： bats todo_test.bats

setup() {
  export TODO_FILE="$(pwd)/storage/todo.txt"
  mkdir -p storage
  : > "$TODO_FILE"
}

@test "addコマンドでタスクを追加できる" {
  run bash todo.sh add "テストタスク1"
  [ "$status" -eq 0 ]
  grep -q "テストタスク1" "$TODO_FILE"
}

@test "listコマンドでタスク一覧が表示される" {
  echo "タスクA" >> "$TODO_FILE"
  echo "タスクB" >> "$TODO_FILE"
  run bash todo.sh list
  [ "$status" -eq 0 ]
  [[ "$output" == *"1. タスクA"* ]]
  [[ "$output" == *"2. タスクB"* ]]
}

@test "delコマンドで指定番号のタスクが削除される" {
  echo "タスクA" >> "$TODO_FILE"
  echo "タスクB" >> "$TODO_FILE"
  run bash todo.sh del 1
  [ "$status" -eq 0 ]
  ! grep -q "タスクA" "$TODO_FILE"
  grep -q "タスクB" "$TODO_FILE"
}

@test "delコマンドで番号未指定時はエラー" {
  run bash todo.sh del
  [ "$status" -eq 1 ]
  [[ "$output" == *"削除する番号を指定してください。"* ]]
}

@test "delコマンドでゼロ番指定はエラー" {
  echo "タスクA" >> "$TODO_FILE"
  run bash todo.sh del -1
  [ "$status" -eq 1 ]
  [[ "$output" == *"削除する番号は1以上の整数で指定してください。"* ]]
}

@test "delコマンドでマイナス番号はエラー" {
  echo "タスクA" >> "$TODO_FILE"
  run bash todo.sh del -1
  [ "$status" -eq 1 ]
  [[ "$output" == *"削除する番号は1以上の整数で指定してください。"* ]]
}

@test "delコマンドで不正な番号はエラー" {
  echo "タスクA" >> "$TODO_FILE"
  run bash todo.sh del abc
  [ "$status" -eq 1 ]
  [[ "$output" == *"削除する番号は1以上の整数で指定してください。"* ]]
}

@test "delコマンドで範囲外の番号はエラー" {
  echo "タスクA" >> "$TODO_FILE"
  run bash todo.sh del 5
  [ "$status" -eq 1 ]
  [[ "$output" == *"指定された番号は範囲外です。ファイルには 1 行しかありません。"* ]]
}

@test "引数無しはヘルプを表示しエラー終了" {
  run bash todo.sh
  [ "$status" -eq 1 ]
  [[ "$output" == *"使い方: todo.sh {add タスク内容 | list | del 番号}"* ]]
}

@test "不正なコマンドはヘルプを表示しエラー終了" {
  run bash todo.sh foo
  [ "$status" -eq 1 ]
  [[ "$output" == *"使い方: todo.sh {add タスク内容 | list | del 番号}"* ]]
}
