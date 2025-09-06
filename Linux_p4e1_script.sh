#!/bin/bash

LOG_DIR="./logs"
LOG_FILE="$LOG_DIR/monitor_$(date +%Y-%m-%d).log"
STDERR_FILE="$LOG_DIR/monitor_$(date +%Y-%m-%d).err"
INTERVAL=60  # Секунды между проверками

mkdir -p "$LOG_DIR"
DEBUG=0
while getopts "d" opt; do
  case $opt in
    d) DEBUG=1 ;;
    *) echo "Usage: $0 [-d]" >&2; exit 1 ;;
  esac
done

if [ $DEBUG -eq 1 ]; then
  set -x
fi
monitor() {
  echo "=== Мониторинг на $(date) ===" >> "$LOG_FILE"
  echo "Загрузка CPU:" >> "$LOG_FILE"
  top -bn1 | grep "load average" >> "$LOG_FILE" 2>> "$STDERR_FILE"

  echo "Память:" >> "$LOG_FILE"
  free -h >> "$LOG_FILE" 2>> "$STDERR_FILE"

  echo "Диск:" >> "$LOG_FILE"
  df -h >> "$LOG_FILE" 2>> "$STDERR_FILE"
}
rotate_logs() {
  find "$LOG_DIR" -type f -name "*.log" -mtime +3 -delete
  find "$LOG_DIR" -type f -name "*.err" -mtime +3 -delete
}
cleanup() {
  echo "Получен сигнал завершения. Ротация логов и выход." >> "$LOG_FILE"
  rotate_logs
  exit 0
}

trap cleanup SIGINT SIGTERM
while true; do
  monitor
  rotate_logs  # Ротация после каждой проверки или по расписанию
  sleep $INTERVAL
done
