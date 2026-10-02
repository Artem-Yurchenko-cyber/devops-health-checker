# DevOps Observability & Interactive Alerting Suite

Повноцінний комплекс моніторингу інфраструктури та автоматизованого сповіщення про аварії (Incident Management) з інтерактивним Telegram-ботом.

Проєкт об'єднує метрики інфраструктури (Prometheus + Node Exporter), візуалізацію (Grafana) та кастомний контейнеризований агент перевірки доступності з інтелектуальним алертингом (Bash + Python).

---

## Технологічний стек

* **Infrastructure Monitoring:** Prometheus, Node Exporter.
* **Visualization:** Grafana (Dashboards & Metrics).
* **Automation & Scripting:** Bash (curl), Python 3.10 (Telegram Bot API, psutil).
* **Orchestration & Containerization:** Docker, Docker Compose.
* **Security:** Dotenv (.env) & Gitignore.

---

## Ключові можливості

1. **Full-Stack Observability:** Збір метрик хост-машини та візуалізація стану систем у Grafana.
2. **Multi-Target Service Discovery:** Перевірка декількох сервісів (Grafana, Prometheus, Node Exporter) через внутрішню мережу Docker.
3. **Smart Alerting System:**
   * Шле **ALERT** у Telegram тільки при переході стану з UP на DOWN.
   * Шле **RECOVERY** один раз при відновленні працездатності.
   * Повністю усунено проблему спаму повідомленнями.
4. **Interactive Telegram Bot:**
   * Реагує на команду `/status` у приватних повідомленнях.
   * Повертає актуальні дані про завантаження CPU, RAM та диска.

---

## Структура проєкту

```text
.
├── docker-compose.yml  # Оркестрація 4-х сервісів
├── Dockerfile          # Збірка агента моніторингу
├── prometheus.yml      # Конфігурація таргетів моніторингу
├── check_status.sh     # Скрипт перевірки доступності сервісів
├── send_telegram.py    # Telegram бот та обробник команд
├── .env.example        # Шаблон секретів
└── README.md           # Документація
Швидкий запуск
Клонувати репозиторій:

Bash
git clone [https://github.com/Artem-Yurchenko-cyber/devops-health-checker.git](https://github.com/Artem-Yurchenko-cyber/devops-health-checker.git)
cd devops-health-checker
Налаштувати секрети:

Bash
cp .env.example .env
Вкажіть у .env свій BOT_TOKEN та CHAT_ID.

Запустити весь стек:

Bash
docker compose up -d --build
Доступ до сервісів
Grafana: http://localhost:3000 (admin/admin)

Prometheus: http://localhost:9090

Node Exporter: http://localhost:9100/metrics