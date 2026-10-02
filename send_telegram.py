import os
import sys
import time
import requests
import psutil

BOT_TOKEN = os.getenv("BOT_TOKEN")
CHAT_ID = os.getenv("CHAT_ID")


def send_message(text):
    if not BOT_TOKEN or not CHAT_ID:
        print("[ERROR] BOT_TOKEN or CHAT_ID is not set!")
        return
    url = f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage"
    payload = {"chat_id": CHAT_ID, "text": text}
    try:
        requests.post(url, json=payload, timeout=5)
    except Exception as e:
        print(f"[ERROR] Failed to send message: {e}")


def get_system_metrics():
    cpu = psutil.cpu_percent(interval=1)
    memory = psutil.virtual_memory().percent
    disk = psutil.disk_usage("/").percent
    return f"System Metrics:\n- CPU Usage: {cpu}%\n- RAM Usage: {memory}%\n- Disk Usage: {disk}%"


def check_bot_commands():
    if not BOT_TOKEN:
        return

    url = f"https://api.telegram.org/bot{BOT_TOKEN}/getUpdates"
    last_update_id = 0

    while True:
        try:
            response = requests.get(
                url, params={"offset": last_update_id + 1, "timeout": 5}
            )
            data = response.json()

            if data.get("ok") and data.get("result"):
                for update in data["result"]:
                    last_update_id = update["update_id"]
                    message = update.get("message", {})
                    text = message.get("text", "")

                    if text == "/status" or text == "/metrics":
                        metrics_info = get_system_metrics()
                        send_message(f"Current System State:\n\n{metrics_info}")
        except Exception as e:
            print(f"[ERROR] Command listener error: {e}")

        time.sleep(3)


if __name__ == "__main__":
    if len(sys.argv) > 1:
        # Якщо передано аргумент — просто надсилаємо сповіщення
        message_text = " ".join(sys.argv[1:])
        send_message(message_text)
    else:
        # Якщо аргументів немає — запускаємо постійний слухач команд
        check_bot_commands()