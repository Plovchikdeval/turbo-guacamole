FROM python:3.10-slim

ENV SHARKHOST=true \
    GIT_PYTHON_REFRESH=quiet \
    PIP_NO_CACHE_DIR=1

RUN apt update && \
    apt install -y --no-install-recommends \
        curl libcairo2 git ffmpeg \
        libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libavdevice-dev \
        gcc python3-dev


RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

RUN rm -rf /var/lib/apt/lists /var/cache/apt/archives /tmp/*

RUN git clone https://github.com/FoxUserbot/FoxUserbot /Fox

WORKDIR /Fox

EXPOSE 8080

CMD ["python3", "main.py"]
