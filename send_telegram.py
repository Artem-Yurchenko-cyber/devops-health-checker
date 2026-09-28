import sys 
import json
import os
import urllib.request

TOKEN = os.getenv("BOT_TOKEN", "")
CHAT_ID = os.getenv("CHAT_ID", "")

URL = f"https://api.telegram.org/bot{TOKEN}/sendMessage"

message = sys.argv[1] if len(sys.argv) > 1 else "Hello from Python script!"

payload = {
    "chat_id": CHAT_ID,
    "text": message
}

data = json.dumps(payload).encode('utf-8')

req = urllib.request.Request(
    URL,
    data=data,
    headers={'Content-Type': 'application/json'}
)

try:
    with urllib.request.urlopen(req) as response:
        print("[OK] Message sent to Telegram successful")
except Exception as e:
    print(f"[ERROR] Failed to send message: {e}")


