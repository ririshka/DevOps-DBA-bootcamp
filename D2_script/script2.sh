#!/bin/bash

# Проверяем количество аргументов
if [[ $# -lt 3 ]]; then
  echo "Использование: $0 [-y] <директория> <маска> <количество_дней>"
  echo "Пример: $0 /tmp '*.txt' 10"
  exit 1
fi

# Проверяем, указана ли опция -y
confirm="yes"
if [[ $1 == "-y" ]]; then
  confirm="no"
  shift
fi

# Получаем параметры
directory=$1
mask=$2
days=$3

# Находим файлы по заданной маске и времени последней модификации
files_to_delete=$(find "$directory" -type f -name "$mask" -mtime +$days)

# Проверка наличия файлов для удаления
if [[ -z "$files_to_delete" ]]; then
  echo "Файлы, соответствующие маске '$mask' и старше $days дней, не найдены в $directory."
  exit 0
fi

# Вывод списка файлов и запрос подтверждения, если нужно
if [[ $confirm == "yes" ]]; then
  echo "Будут удалены следующие файлы:"
  echo "$files_to_delete"
  read -p "Вы уверены, что хотите удалить эти файлы? (y/n): " user_input
  if [[ $user_input != "y" ]]; then
    echo "Удаление отменено."
    exit 0
  fi
fi

# Удаление файлов
echo "$files_to_delete" | xargs rm -f
echo "Файлы успешно удалены."
