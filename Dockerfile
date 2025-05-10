FROM alpine:latest

# Установка переменной окружения
ENV DOCKER=true

# Установка зависимостей и Python 3.10
RUN apk update && apk add --no-cache \
    build-base \
    python3 \
    python3-dev \
    py3-pip \
    git \
    cairo-dev \
    ffmpeg \
    curl \
    bash \
    nodejs \
    npm

# Символическая ссылка для python и обновление pip
RUN ln -sf python3 /usr/bin/python && pip install --upgrade pip

# Клонирование репозитория
RUN git clone https://github.com/Hikariatama/Hikka /Hikka

# Установка рабочей директории
WORKDIR /Hikka

# Установка зависимостей Python
RUN pip install --no-cache-dir --no-warn-script-location -U -r requirements.txt

# Указание порта
EXPOSE 8080

# Стартовая команда
CMD ["python", "-m", "hikka"]
