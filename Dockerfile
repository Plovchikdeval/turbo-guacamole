# Базовый образ Ubuntu 22.04
FROM ubuntu:22.04

# Установка переменной окружения
ENV DEBIAN_FRONTEND=noninteractive
ENV DOCKER=true
ENV AIOHTTP_NO_EXTENSIONS=1
ENV SKIRIHOST=true

# Обновление пакетов и установка зависимостей
RUN apt update && apt install -y --no-install-recommends \
    python3.10 \
    python3.10-dev \
    python3-pip \
    build-essential \
    git \
    libcairo2 \
    libcairo2-dev \
    ffmpeg \
    curl \
    bash \
    ca-certificates \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Символическая ссылка для python
RUN ln -s /usr/bin/python3.10 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip && \
    pip install --upgrade pip

# Клонирование репозитория
RUN git clone https://github.com/Crayz310/Legacy /Legacy

# Переход в рабочую директорию
WORKDIR /Legacy

# Установка Python-зависимостей
RUN pip install --no-warn-script-location --no-cache-dir -U -r requirements.txt

# Открываем порт
EXPOSE 8080

# Команда запуска
CMD ["python", "-m", "legacy"]
