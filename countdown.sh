#!/bin/bash

# カウントダウンタイマー
# 指定した秒数から0までカウントダウンし、終了時に「時間です！」と表示します。
# 使い方: bash countdown.sh 秒数

if [ $# -ne 1 ]; then
  echo "使い方: $0 秒数"
  exit 1
fi

seconds=$1

if ! [[ $seconds =~ ^[1-9][0-9]*$ ]]; then
  echo "秒数は1以上の整数で指定してください。"
  exit 1
fi

while [ "$seconds" -gt 0 ]; do
  printf "\r%3d " "$seconds"
  sleep 1
  seconds=$((seconds - 1))
done

printf "\r    \r"
echo "時間です！"
