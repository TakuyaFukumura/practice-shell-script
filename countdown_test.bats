#!/usr/bin/env bats

# countdown.shのテスト
# 実行方法: bats countdown_test.bats

setup() {
  export SCRIPT="$(pwd)/countdown.sh"
}

@test "指定した秒数からカウントダウンし終了メッセージが表示される" {
  run bash "$SCRIPT" 2
  [ "$status" -eq 0 ]
  [[ "$output" == *"2"* ]]
  [[ "$output" == *"1"* ]]
  [[ "$output" == *"時間です！"* ]]
}

@test "引数なしはエラー終了し使い方を表示" {
  run bash "$SCRIPT"
  [ "$status" -eq 1 ]
  [[ "$output" == *"使い方:"* ]]
}

@test "負の値はエラーで終了しメッセージを表示" {
  run bash "$SCRIPT" -5
  [ "$status" -eq 1 ]
  [[ "$output" == *"秒数は1以上の整数で指定してください。"* ]]
}

@test "0秒はエラーで終了しメッセージを表示" {
  run bash "$SCRIPT" 0
  [ "$status" -eq 1 ]
  [[ "$output" == *"秒数は1以上の整数で指定してください。"* ]]
}

@test "不正な引数はエラーで終了しメッセージを表示" {
  run bash "$SCRIPT" abc
  [ "$status" -eq 1 ]
  [[ "$output" == *"秒数は1以上の整数で指定してください。"* ]]
}
