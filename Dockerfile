# Используем базовый образ
FROM python:3.12-slim

# Устанавливаем OpenSSH-клиент
RUN apt-get update && apt-get install -y \
git \
build-essential \
curl \
make \
openssh-client \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Устанавливаем Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Добавляем Poetry в PATH
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

# Клонируем репозиторий
WORKDIR /app
CMD git clone git@github.com:rocket-duck/smb_bot.git && \
    make install && \
    make bot-run
