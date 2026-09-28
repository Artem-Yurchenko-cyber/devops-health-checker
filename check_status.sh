#!/bin/bash

URL="http://host.docker.internal:3000/api/health"

STATUS_CODE=$(curl -s -L -o /dev/null -w "%{http_code}" "$URL")

if [ "$STATUS_CODE" -eq 200 ]; then
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [OK] Service is UP. Code: ${STATUS_CODE}"
else
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [ERROR] Service is DOWN. Code: ${STATUS_CODE}"
    python send_telegram.py "ALERT: Service Grafana is DOWN! HTTP Code: ${STATUS_CODE}"
fi

