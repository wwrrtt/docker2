#!/bin/bash

# 定义 UUID 及 伪装路径,请自行修改.(注意:伪装路径以 / 符号开始,为避免不必要的麻烦,请不要使用特殊符号.)
export Token=${Token:-'eyJhIjoiYjQ2N2Q5MGUzZDYxNWFhOTZiM2ZmODU5NzZlY2MxZjgiLCJ0IjoiNmZlMjE3MDEtYmRhOC00MzczLWIxMzAtYTkwOGMyZGUzZWJkIiwicyI6Ik1UUTBNMlUxTkRRdE1UazBaaTAwTW1FeUxUazFOalV0WVRObVl6RXlPVGhoTkRsbSJ9'}

# 启动xray
nohup ./web run ./config.json >/dev/null 2>&1 &
if [ $? -ne 0 ]; then
    echo "Error: Failed to start web"
    exit 1
fi

# 启动cf tunnel
nohup ./argo tunnel --edge-ip-version auto run --token $Token  >/dev/null 2>&1 &
if [ $? -ne 0 ]; then
    echo "Error: Failed to start argo"
    exit 1
fi

echo "----- 系统进程...----- ."
ps -ef

echo "----- 系统信息...----- ."
cat /proc/version
echo "----- good luck (kid).----- ."
