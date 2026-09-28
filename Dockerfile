FROM python:3.10-slim
RUN apt-get update && apt-get install -y curl bash && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY check_status.sh send_telegram.py ./
ENV BOT_TOKEN=""
ENV CHAT_ID=""
RUN chmod +x check_status.sh
CMD ["bash", "-c", "while true; do ./check_status.sh; sleep 15; done"]


