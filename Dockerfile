FROM python:3.10-slim

# Установка переменной окружения
ENV DOCKER=true

# Установка необходимых зависимостей
RUN apt update && apt install -y --no-install-recommends \
    libcairo2 \
    git \
    build-essential \
    ffmpeg \
    curl \
    bash \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /tmp/*

# Установка Node.js 18
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt install -y nodejs && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /tmp/*

# Клонирование репозитория
RUN git clone https://github.com/coddrago/Heroku /Heroku

# Установка рабочей директории
WORKDIR /Heroku

# Установка зависимостей Python
RUN pip install --no-warn-script-location --no-cache-dir -U -r requirements.txt

# Указание порта
EXPOSE 8080

# Стартовая команда: git pull --rebase и запуск Python
ENTRYPOINT ["/bin/bash", "-c", "git pull --rebase origin master && exec python -m hikka"]
