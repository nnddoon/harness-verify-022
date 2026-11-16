#!/usr/bin/env bash
# 由 harness init 生成（检测到：python）。可以随时改；重跑 init 不会覆盖。
# 改完一个文件立刻跑，只检查这一个文件；非 0 = 结果回给 Claude。
case "$1" in
  *.py) python3 -B -m py_compile "$1" ;;
esac
