#!/bin/bash

# Списоки сервісів у форматі "Назва|URL"
SERVICES=(
    "Grafana|http://grafana:3000/api/health"
    "Prometheus|http://prometheus:9090/-/healthy"
    "Node-Exporter|http://node_exporter:9100"
)

for ITEM in "${SERVICES[@]}"; do
    NAME=$(echo "$ITEM" | cut -d'|' -f1)
    URL=$(echo "$ITEM" | cut -d'|' -f2)
    STATUS_FILE="/tmp/last_status_${NAME}"

    if [ ! -f "$STATUS_FILE" ]; then
        echo "UP" > "$STATUS_FILE"
    fi

    LAST_STATUS=$(cat "$STATUS_FILE")
    STATUS_CODE=$(curl -s -L -o /dev/null -w "%{http_code}" "$URL")

    if [ "$STATUS_CODE" -eq 200 ]; then
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] [OK] ${NAME} is UP. Code: ${STATUS_CODE}"
        
        if [ "$LAST_STATUS" = "DOWN" ]; then
            python send_telegram.py "RECOVERY: Service ${NAME} is back UP! Code: ${STATUS_CODE}"
            echo "UP" > "$STATUS_FILE"
        fi
    else
        echo "[$(date +'%Y-%m-%d %H:%M:%S')] [ERROR] ${NAME} is DOWN! Code: ${STATUS_CODE}"
        
        if [ "$LAST_STATUS" = "UP" ]; then
            python send_telegram.py "ALERT: Service ${NAME} is DOWN! Code: ${STATUS_CODE}"
            echo "DOWN" > "$STATUS_FILE"
        fi
    fi
done