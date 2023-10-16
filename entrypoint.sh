#!/bin/bash

# 定义 UUID 及 伪装路径,请自行修改.(注意:伪装路径以 / 符号开始,为避免不必要的麻烦,请不要使用特殊符号.)
export Token=${Token:-'eyJhIjoiYjQ2N2Q5MGUzZDYxNWFhOTZiM2ZmODU5NzZlY2MxZjgiLCJ0IjoiZjc1ZWExNzgtODE3ZC00MmNhLWEyOTktMDc4NTAzNmYwN2FhIiwicyI6Ill6UmxNRFUyTkdVdFpqZzBNeTAwTldWakxUZzROR010TWpVeU56RXhZalE0WlRRMyJ9'}

#!/bin/sh

# Start cf tunnel
nohup ./argo tunnel --edge-ip-version auto run --token $Token  >/dev/null 2>&1 &

# Check if the tunnel started successfully
if [ $? -eq 0 ]; then
    echo "argo Tunnel started successfully."
else
    echo "Failed to start argo."
    exit 1
fi

# Start xray
nohup ./web run ./config.json >/dev/null 2>&1 &

# Check if xray started successfully
if [ $? -eq 0 ]; then
    echo "web started successfully."
else
    echo "Failed to start web."
    exit 1
fi
