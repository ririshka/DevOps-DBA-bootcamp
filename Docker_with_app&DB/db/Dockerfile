FROM postgres:15                           # Используем официальный образ PostgreSQL версии 15

ENV POSTGRES_USER=user                     # Задаём имя пользователя базы данных
ENV POSTGRES_PASSWORD=password             # Устанавливаем пароль пользователя
ENV POSTGRES_DB=mydb                       # Указываем имя базы данных

COPY init.sql /docker-entrypoint-initdb.d/ # Копируем SQL-скрипт для инициализации данных

