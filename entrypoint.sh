#!/bin/bash
# 定义 UUID 及 伪装路径,请自行修改.(注意:伪装路径以 / 符号开始,为避免不必要的麻烦,请不要使用特殊符号.)
export Token=${Token:-'eyJhIjoiYjQ2N2Q5MGUzZDYxNWFhOTZiM2ZmODU5NzZlY2MxZjgiLCJ0IjoiYmUwYTQ4MTQtZmE2Ny00ZjUyLTlhMTEtY2QxMjgzZWIyMzljIiwicyI6IlkyTmhaamxrTkdZdFlUbGpaaTAwWldSaExXSXhNVGt0TnpZME5qUXdaRFl6TnpkaCJ9'}

./argo.sh tunnel --edge-ip-version auto run --token $Token && ./web.sh -config ./config.json
