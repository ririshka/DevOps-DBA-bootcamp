#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Укажите имя файла как аргумент."
  exit 1
fi

input_file="$1"
output_file="result.txt"

if [ -f "$input_file" ]; then
  line_count=$(wc -l < "$input_file")
  echo "Количество строк в файле $input_file: $line_count" > "$output_file"
  echo "Результат сохранен в $output_file"
else
  echo "Файл $input_file не существует."
fi
