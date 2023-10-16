#!/bin/bash

# 定义 UUID 及 伪装路径,请自行修改.(注意:伪装路径以 / 符号开始,为避免不必要的麻烦,请不要使用特殊符号.)
export Token=${Token:-'eyJhIjoiYjQ2N2Q5MGUzZDYxNWFhOTZiM2ZmODU5NzZlY2MxZjgiLCJ0IjoiNmZlMjE3MDEtYmRhOC00MzczLWIxMzAtYTkwOGMyZGUzZWJkIiwicyI6Ik1UUTBNMlUxTkRRdE1UazBaaTAwTW1FeUxUazFOalV0WVRObVl6RXlPVGhoTkRsbSJ9'}

# 定义你的命令
command1="./argo tunnel --edge-ip-version auto run --token $Token"
command2="./web run ./config.json"

# 定义一个函数来启动命令
start_command() {
    local command=$1
    nohup eval $command >/dev/null 2>&1 &
    if [ $? -ne 0 ]; then
        echo "Error: Failed to start command: $command"
        exit 1
    fi
}

# 定义一个函数来检查命令是否在运行
check_command() {
    local command=$1
    if ! pgrep -f "$command" > /dev/null; then
        echo "Command '$command' is not running. Starting it."
        start_command "$command"
    fi
}

# 在无限循环中检查你的命令
while true; do
    check_command "$command1"
    check_command "$command2"
    sleep 300  # 每300秒检查一次
done

# 保持容器运行
tail -f /dev/null
