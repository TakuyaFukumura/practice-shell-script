#!/bin/bash

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
