#!/bin/bash

# カウントダウンタイマー
# 指定した秒数から0までカウントダウンし、終了時に「時間です！」と表示します。
# 使い方: bash countdown.sh 秒数

if [ $# -ne 1 ]; then
  echo "使い方: $0 秒数"
  exit 1
fi

seconds=$1

while [ $seconds -gt 0 ]; do
  echo -ne "$seconds\r"
  sleep 1
  seconds=$((seconds - 1))
done

echo "時間です！"
