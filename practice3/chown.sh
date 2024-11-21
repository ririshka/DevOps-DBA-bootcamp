#!/bin/bash

directory=$1

if [ $# -eq 0 ]; then
  echo "Укажите путь к каталогу как аргумент."
  exit 1
fi

if [ -d "$directory" ]; then
  sudo chown -R user1:testgrp "$directory"   # Изменение владельца и группы
  sudo find "$directory" -type f -exec chmod 764 {} \;   # Изменение прав для файлов
  sudo find "$directory" -type d -exec chmod 775 {} \;   # Изменение прав для папок
  echo "Права доступа и владельцы обновлены для каталога $directory"
else
  echo "Каталог $directory не существует."
fi
