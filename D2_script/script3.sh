#!/bin/bash

# Получаем текущие дату и время для использования в названии файла
current_date=$(date +"%Y-%m-%d_%H-%M-%S")
report_file="system_report_$current_date.txt"

# Проверка наличия email-адреса в аргументах
email="$1"

# Функция для записи информации в отчет
generate_report() {
  echo "Отчет о загрузке системных ресурсов" > "$report_file"
  echo "Дата и время: $(date)" >> "$report_file"
  echo "==============================" >> "$report_file"

  # CPU Usage
  echo "CPU Загрузка:" >> "$report_file"
  mpstat | grep "all" >> "$report_file"
  echo "==============================" >> "$report_file"

  # Memory Usage
  echo "Использование памяти:" >> "$report_file"
  free -h >> "$report_file"
  echo "==============================" >> "$report_file"

  # Disk Usage
  echo "Использование диска:" >> "$report_file"
  df -h >> "$report_file"
  echo "==============================" >> "$report_file"

  # Top 5 CPU consuming processes
  echo "Топ-5 процессов по использованию CPU:" >> "$report_file"
  ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6 >> "$report_file"
  echo "==============================" >> "$report_file"

  # Top 5 Memory consuming processes
  echo "Топ-5 процессов по использованию памяти:" >> "$report_file"
  ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6 >> "$report_file"
  echo "==============================" >> "$report_file"

  echo "Отчет сохранен в $report_file"
}

# Генерация отчета
generate_report

# Отправка отчета по e-mail, если указан адрес
if [[ -n "$email" ]]; then
  if command -v mail >/dev/null 2>&1; then
    cat "$report_file" | mail -s "System Resource Report $current_date" "$email"
    echo "Отчет отправлен на $email"
  else
    echo "Команда 'mail' не найдена. Установите её для отправки e-mail."
  fi
fi
