FROM python:3.10-slim

# Установка переменных окружения
ENV DOCKER=true
ENV IS_DJHOST=true
ENV GIT_PYTHON_REFRESH=quiet

ENV PIP_NO_CACHE_DIR=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Установка необходимых зависимостей
RUN apt update && apt install -y --no-install-recommends \
    libcairo2 \
    git \
    build-essential \
    ffmpeg \
    curl \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives /tmp/*

# Установка Node.js 18
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt install -y nodejs && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives /tmp/*

# Создание директории для данных
RUN mkdir /data

# Клонирование репозитория
RUN git clone https://github.com/coddrago/Heroku /Heroku

# Установка рабочей директории
WORKDIR /Heroku

# Установка зависимостей Python
RUN pip install --no-warn-script-location --no-cache-dir -U -r requirements.txt

# Указание порта
EXPOSE 8080

# Команда для запуска приложения с обновлением репозитория
CMD sh -c "git pull origin master && python -m hikka"
