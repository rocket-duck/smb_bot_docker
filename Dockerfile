# Используем базовый образ
FROM python:3.12-slim

# Устанавливаем OpenSSH-клиент и другие зависимости
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    curl \
    make \
    openssh-client \
    python3-pip \
    python3-venv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем pipx
RUN python3 -m pip install --no-cache-dir pipx && \
    python3 -m pipx ensurepath

# Добавляем pipx в PATH
ENV PATH="/root/.local/bin:$PATH"

# Создаём директорию для ключей
RUN mkdir -p /root/.ssh

# Копируем SSH-ключи в контейнер
COPY id_rsa /root/.ssh/id_rsa
COPY id_rsa.pub /root/.ssh/id_rsa.pub

# Устанавливаем права доступа
RUN chmod 600 /root/.ssh/id_rsa

# Добавляем GitHub в известные хосты
RUN ssh-keyscan -t rsa github.com >> /root/.ssh/known_hosts

# Устанавливаем рабочую директорию
WORKDIR /app

# Клонируем репозиторий
RUN git clone git@github.com:rocket-duck/smb_bot.git smb_bot

# Переходим в папку репозитория
WORKDIR /app/smb_bot

# Устанавливаем Poetry через pipx
RUN pipx install poetry

# Выполняем команды через Makefile
CMD git pull && make install && make bot-run
