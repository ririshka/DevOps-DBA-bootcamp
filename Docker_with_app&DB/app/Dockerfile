FROM python:3.9-slim                      # Используем минимальный образ Python 3.9

WORKDIR /app                              # Устанавливаем рабочую директорию в контейнере

COPY requirements.txt requirements.txt    # Копируем файл с зависимостями
RUN pip install -r requirements.txt       # Устанавливаем зависимости через pip

COPY . .                                  # Копируем все файлы приложения в контейнер

CMD ["python", "app.py"]                  # Указываем команду для запуска приложения
