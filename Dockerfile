# -------------------------------
# Используем базовый образ Ubuntu 20.04
FROM ubuntu:20.04

# Отключаем интерактивный режим apt для предотвращения зависаний при установке
ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_NO_CACHE_DIR=1

# Устанавливаем необходимые пакеты для сборки Python, git и зависимостей
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3.10 python3-pip python3-dev \
    gcc git curl libcairo2 ffmpeg libmagic1 \
    libavcodec-dev libavutil-dev libavformat-dev \
    libswscale-dev libavdevice-dev neofetch wkhtmltopdf nodejs npm && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

# Устанавливаем Node.js 18
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

# Клонируем репозиторий Hikka
RUN git clone https://github.com/Plovchikdeval/Heroku /Hikka

# Устанавливаем зависимости Python
RUN pip3 install --no-warn-script-location --no-cache-dir -r /Hikka/requirements.txt

# Устанавливаем рабочую директорию
WORKDIR /Hikka

# Устанавливаем переменные окружения для работы приложения
ENV DOCKER=true \
    IS_DJHOST=true \
    rate=basic \
    GIT_PYTHON_REFRESH=quiet \
    PIP_NO_CACHE_DIR=1

# Открываем порт 8080 для доступа к приложению
EXPOSE 8080

# Определяем команду запуска приложения
CMD ["python3", "-m", "hikka"]
