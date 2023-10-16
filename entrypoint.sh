#!/bin/bash

# 定义 UUID 及 伪装路径,请自行修改.(注意:伪装路径以 / 符号开始,为避免不必要的麻烦,请不要使用特殊符号.)
export Token=${Token:-'eyJhIjoiYjQ2N2Q5MGUzZDYxNWFhOTZiM2ZmODU5NzZlY2MxZjgiLCJ0IjoiZjc1ZWExNzgtODE3ZC00MmNhLWEyOTktMDc4NTAzNmYwN2FhIiwicyI6Ill6UmxNRFUyTkdVdFpqZzBNeTAwTldWakxUZzROR010TWpVeU56RXhZalE0WlRRMyJ9'}

while true; do
    # 检查argo进程是否在运行
    if ! pgrep -x "argo" > /dev/null; then
        # 如果argo进程没有运行，那么启动它
        nohup ./argo tunnel --edge-ip-version auto run --token $Token  >/dev/null 2>&1 &
        echo "argo Tunnel started successfully."
    fi

    # 检查web进程是否在运行
    if ! pgrep -x "web" > /dev/null; then
        # 如果web进程没有运行，那么启动它
        nohup ./web run ./config.json >/dev/null 2>&1 &
        echo "web started successfully."
    fi

    # 等待一段时间后再次检查
    sleep 300
done
