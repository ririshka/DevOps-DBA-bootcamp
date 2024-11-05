#!/bin/bash

# 0. Удаляем все файлы из /tmp/result/
rm -rf /tmp/result/*
mkdir -p /tmp/result

# 1. Создаем директории disk, process, memory, user внутри resources
mkdir -p resources/{disk,process,memory,user}

# 2. Создаем файлы d.txt, p.txt, m.txt, u.txt в папке resources
touch resources/d.txt resources/p.txt resources/m.txt resources/u.txt

# 3. Записываем информацию о свободном месте на дисках в d.txt
df -h > resources/d.txt

# 4. Записываем информацию о 10 самых ресурсоёмких процессах в p.txt
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 11 > resources/p.txt

# 5. Записываем информацию об оперативной памяти в m.txt
free -h > resources/m.txt

# 6. Записываем информацию о пользователе, запустившем скрипт, в u.txt
{
  echo "Информация из /etc/passwd:"
  grep "^$(whoami):" /etc/passwd
  echo -e "\nВремя последнего логина:"
  last -n 1 $(whoami)
  echo -e "\nГруппы пользователя:"
  groups $(whoami)
  echo -e "\nСодержание домашней директории:"
  ls -la ~
} > resources/u.txt

# 7. Перемещаем d.txt, p.txt, m.txt в соответствующие директории и переименовываем их
mv resources/d.txt resources/disk/disk.txt
mv resources/p.txt resources/process/process.txt
mv resources/m.txt resources/memory/memory.txt

# 8. Копируем u.txt в папку user и переименовываем
cp resources/u.txt resources/user/user.txt

# 9. Изменяем группу на resgrp и права для директорий и файлов
chgrp -R resgrp resources/{disk,process,memory,user}
chmod -R 760 resources/{disk,process,memory,user}

# 10. Создаем архив resources с текущей датой и временем, сохраняем в /tmp/result/
archive_name="resources_$(date +'%Y%m%d_%H%M%S').tar.gz"
tar -czf "/tmp/result/$archive_name" resources

echo "Скрипт выполнен успешно. Архив создан: /tmp/result/$archive_name"
