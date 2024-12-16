# Используем базовый образ
FROM python:3.12-slim

# Устанавливаем OpenSSH-клиент
RUN apt-get update && apt-get install -y openssh-client git && apt-get clean

# Создаём директорию для ключей
RUN mkdir -p /root/.ssh

# Копируем SSH-ключи в контейнер
COPY id_rsa /root/.ssh/id_rsa
COPY id_rsa.pub /root/.ssh/id_rsa.pub

# Устанавливаем права доступа
RUN chmod 600 /root/.ssh/id_rsa

# Добавляем GitHub в известные хосты
RUN ssh-keyscan -t rsa github.com >> /root/.ssh/known_hosts

# Клонируем репозиторий
WORKDIR /app
CMD git clone git@github.com:rocket-duck/smb_bot_docker.git . && \
    make install && \
    make bot-run
