#!/bin/bash

directory=$1
destination=$2

if [ $# -lt 2 ]; then
  echo "Использование: $0 <каталог> <путь для сохранения архива>"
  exit 1
fi

if [ -d "$directory" ]; then
  current_date=$(date +%Y-%m-%d)
  archive_name="$destination/$(basename "$directory")-$current_date.tar.gz"
  tar -czf "$archive_name" "$directory"
  echo "Каталог $directory успешно заархивирован в $archive_name"
else
  echo "Каталог $directory не существует."
fi
