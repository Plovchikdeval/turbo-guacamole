# Базовый образ Ubuntu 22.04
FROM ubuntu:22.04

# Установка переменных окружения
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

# Создание символических ссылок, если они ещё не существуют
RUN [ ! -e /usr/bin/python ] && ln -s /usr/bin/python3.10 /usr/bin/python || true && \
    [ ! -e /usr/bin/pip ] && ln -s /usr/bin/pip3 /usr/bin/pip || true && \
    pip install --upgrade pip

# Клонирование репозитория
RUN git clone https://github.com/Crayz310/Legacy /Legacy

# Установка рабочей директории
WORKDIR /Legacy

# Установка Python-зависимостей
RUN pip install --no-warn-script-location --no-cache-dir -U -r requirements.txt

# Открытие порта
EXPOSE 8080

# Команда запуска
CMD ["python", "-m", "legacy"]
