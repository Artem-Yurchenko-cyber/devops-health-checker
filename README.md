# DevOps Health-Checker & Telegram Notifier

Автоматизована система моніторингу сервісів та сповіщення про аварії (Incident Notification) у Telegram. Проєкт розроблено для регулярної перевірки доступності веб-сервісів (на прикладі Grafana) із використанням **Bash**, **Python** та **Docker**.

---

## Технологічний стек

* **Bash** — перевірка HTTP-статусу сервісів за допомогою `curl`.
* **Python 3.10** — взаємодія з Telegram Bot API через HTTP-запити.
* **Docker** — контейнеризація агента моніторингу.
* **Git & GitHub** — версіонування коду та безпечне управління секретами.

---

## Основний функціонал

1. **Periodic Health Check:** Періодичне опитування цільового URL (`/api/health`).
2. **Smart Alerting:** Відправка сповіщень у Telegram тільки при виявленні помилки (`HTTP Status != 200`).
3. **Containerized Execution:** Робота у фоновому режимі всередині ізольованого Docker-контейнера.
4. **Security Best Practices:** Відсутність hardcoded секретів — токени та ключі зчитуються зі змінних оточення (`.env`).

---

## Структура проєкту

```text
.
├── Dockerfile          # Інструкція збірки Docker-образу
├── check_status.sh     # Bash-скрипт перевірки статусу сервісу
├── send_telegram.py    # Python-скрипт відправки алертів у Telegram
├── .env.example        # Шаблон змінних оточення (без секретів)
└── .gitignore          # Ігнорування .env та логів від Git

---
## Клонування репозитрію
git clone [https://github.com/Artem-Yurchenko-cyber/devops-health-checker.git](https://github.com/Artem-Yurchenko-cyber/devops-health-checker.git)
cd devops-health-checker

## Налаштування змінних оточення
Створіть файл .env на основі шаблону та вкажіть свої дані Telegram:
cp .env.example .env
Заповність .env

## Фрагмент коду
BOT_TOKEN=your_telegram_bot_token
CHAT_ID=your_telegram_chat_id

## Збірка та запуск у Docker
Зберіть Docker-образ:
docker build -t health-checker:v1

Запустіть контейнер з підтримкою звернення до хост-машини (host.docker.internal)
docker run -d --name health-checker --env-file .env --add-host=host.docker.internal:host-gateway health-checker:v1

## Результати
При падінні сервісу бот генерує миттєвий алерт у Telegram:
ALER: Service Grafana is DOWN! HTTP Code: 000