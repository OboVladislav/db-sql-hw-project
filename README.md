# SQL Homework Project (PostgreSQL + Docker)
Автор: Ободинский Владислав
## 📌 Описание

Данный проект представляет собой набор SQL-заданий, выполненных в рамках изучения работы с базами данных.

В проекте реализованы решения для 4 различных предметных областей:

- 🚗 **transport_vehicle_db** — транспортные средства
- 🏁 **vehicle_races_db** — автомобильные гонки
- 🏨 **booking_hotel_db** — бронирование отелей
- 🏢 **organization_structure_db** — структура организации

Каждая база данных содержит:
- скрипт создания таблиц (`create.sql`)
- скрипт наполнения данными (`insert.sql`)
- решения задач (`task*.sql`)

---

## 🛠 Используемые технологии

- PostgreSQL 17
- Docker / Docker Compose
- SQL (PostgreSQL dialect)

---

## 📁 Структура проекта

```text
db/
├── docker-compose.yml
├── README.md
├── runner/
│   ├── Dockerfile
│   └── run_all.sh
├── booking_hotel_db/
│   ├── create.sql
│   ├── insert.sql
│   ├── task1.sql
│   ├── task2.sql
│   └── task3.sql
├── organization_structure_db/
│   ├── create.sql
│   ├── insert.sql
│   ├── task1.sql
│   ├── task2.sql
│   └── task3.sql
├── transport_vehicle_db/
│   ├── create.sql
│   ├── insert.sql
│   ├── task1.sql
│   └── task2.sql
├── vehicle_races_db/
│   ├── create.sql
│   ├── insert.sql
│   ├── task1.sql
│   ├── task2.sql
│   └── task3.sql
```
## 🚀 Как запустить проект
### 1. Установить Docker

Убедитесь, что у вас установлен Docker:

👉 https://www.docker.com/

###  2. Запуск проекта

В корне проекта выполните:
```bash
docker compose down -v
docker compose up --build
```

## 📬 Сдача задания

Для проверки необходимо:

- Склонировать репозиторий
- Выполнить:
```bash
docker compose up --build
```
- Убедиться, что все SQL-запросы выполняются без ошибок
## ⚙️ Что происходит при запуске

Контейнер runner автоматически:

1. Ждет, пока PostgreSQL станет доступен
2. Создает базы данных:
- booking_hotel_db
- organization_structure_db
- transport_vehicle_db
- vehicle_races_db
3. Выполняет для каждой базы:
- create.sql
- insert.sql
- все task*.sql

## 🔍 Ручная работа с базой (опционально)

Подключиться к PostgreSQL:
```bash
docker exec -it sql_hw_postgres psql -U postgres
```
Создать БД:
```bash
```
Подключиться к контейнеру: 
```bash
docker exec -it "ID_container" bash 
```
Создать БД:
```bash
docker exec -it sql_hw_postgres psql -U postgres -d postgres -c "CREATE DATABASE database;"
```
Выполнить команду
```bash
psql -U postgres -d database3 -f /workspace/booking_hotel_db/task1.sql
docker exec -it sql_hw_postgres psql -U postgres -d database3 -f /workspace/booking_hotel_db/task1.sql
```
Или:
```bash
\c booking_hotel_db
\dt
SELECT * FROM booking;
``` 
## 🎯 Цель проекта

### Закрепить знания по SQL и работе с реляционными базами данных:

- проектирование структуры БД
- написание сложных SQL-запросов
- работа с агрегациями и аналитикой
- использование рекурсивных запросов

## 📦 Особенности
- Полностью кроссплатформенный запуск (Windows / Linux / macOS)
- Не требует локальной установки PostgreSQL
- Все выполняется внутри Docker