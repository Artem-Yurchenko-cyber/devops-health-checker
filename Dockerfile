FROM python:3.10-slim

RUN apt-get update && apt-get install -y curl bash procps && rm -rf /var/lib/apt/lists/*
RUN pip install requests psutil

WORKDIR /app

COPY check_status.sh send_telegram.py ./
RUN chmod +x check_status.sh

CMD ["bash", "-c", "python send_telegram.py & while true; do ./check_status.sh; sleep 15; done"]