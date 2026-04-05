#!/bin/bash
set -e

echo "Waiting for PostgreSQL..."
until pg_isready -h postgres -U postgres; do
  sleep 2
done

run_db() {
  DB_NAME=$1
  DIR=$2

  echo "====================================="
  echo "Processing $DB_NAME"
  echo "====================================="

  psql -h postgres -U postgres -d postgres -c "DROP DATABASE IF EXISTS $DB_NAME;"
  psql -h postgres -U postgres -d postgres -c "CREATE DATABASE $DB_NAME;"

  echo "Running create.sql for $DB_NAME"
  psql -h postgres -U postgres -d $DB_NAME -f "/workspace/$DIR/create.sql"

  echo "Running insert.sql for $DB_NAME"
  psql -h postgres -U postgres -d $DB_NAME -f "/workspace/$DIR/insert.sql"

  for file in /workspace/$DIR/task*.sql; do
    if [ -f "$file" ]; then
      echo "Running $(basename "$file") for $DB_NAME"
      psql -h postgres -U postgres -d $DB_NAME -f "$file"
    fi
  done

  echo
}

run_db "booking_hotel_db" "booking_hotel_db"
run_db "organization_structure_db" "organization_structure_db"
run_db "transport_vehicle_db" "transport_vehicle_db"
run_db "vehicle_races_db" "vehicle_races_db"

echo "All databases processed successfully."