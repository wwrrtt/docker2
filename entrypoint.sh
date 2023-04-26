#!/bin/bash
# 定义 UUID 及 伪装路径,请自行修改.(注意:伪装路径以 / 符号开始,为避免不必要的麻烦,请不要使用特殊符号.)
export PORT=${PORT-8080}
export UUID=${UUID:-'1bb7c055-8790-4argo.sh4-da53-c9f9bcc669bd'}
export VMESS_WSPATH=${VMESS_WSPATH:-'/ray272449844'}

cat << EOF >config.json
{
	"log": {
		"disabled": false,
		"level": "info",
		"output": "/dev/null",
		"timestamp": true
	},
	"dns": {
		"servers": [
			{
				"tag": "google-tls",
				"address": "local",
				"address_strategy": "prefer_ipv4",
				"strategy": "ipv4_only",
				"detour": "direct"
			},
			{
				"tag": "google-udp",
				"address": "8.8.8.8",
				"address_strategy": "prefer_ipv4",
				"strategy": "prefer_ipv4",
				"detour": "direct"
			}
		],
		"strategy": "prefer_ipv4",
		"disable_cache": false,
		"disable_expire": false
	},
	"inbounds": [
		{
			"type": "vmess",
			"tag": "vmess-in",
			"listen": "0.0.0.0",
			"listen_port": $PORT,
			"tcp_fast_open": false,
			"sniff": false,
			"sniff_override_destination": false,
			"domain_strategy": "prefer_ipv4",
			"proxy_protocol": false,
			"users": [
				{
					"name": "kid",
					"uuid": "$UUID",
					"alterId": 0
				}
			],
		"transport": {
        "type": "ws",
        "path": "$VMESS_WSPATH",
        "max_early_data": 0,
        "early_data_header_name": "Sec-WebSocket-Protocol"
      }
    }
  ],
  "outbounds": [
    {
      "type": "direct",
      "tag": "direct"
    }
  ]
}
EOF

cat config.json | base64 > config
rm -f config.json
base64 -d config > config.json
rm -f config


nginx
nohup ./web.sh run ./config.json >/dev/null 2>&1 &
