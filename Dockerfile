FROM alpine:latest

# Установка переменных окружения
ENV DOCKER=true
ENV AIOHTTP_NO_EXTENSIONS=1

# Установка зависимостей
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

# Символические ссылки
RUN ln -sf python3 /usr/bin/python && ln -sf pip3 /usr/bin/pip

# Клонирование репозитория
RUN git clone https://github.com/Hikariatama/Hikka /Hikka

# Установка рабочей директории
WORKDIR /Hikka

# Установка зависимостей Python
RUN pip install --no-cache-dir --no-warn-script-location --break-system-packages -U -r requirements.txt

# Указание порта
EXPOSE 8080

# Стартовая команда
CMD ["python", "-m", "hikka"]
