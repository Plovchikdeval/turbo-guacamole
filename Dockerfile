FROM python:3.10-slim

ENV DOCKER=true \
    SHARKHOST=true \
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

RUN git clone https://github.com/coddrago/Heroku /Heroku

WORKDIR /Heroku

RUN pip install --no-warn-script-location --no-cache-dir -r requirements.txt

EXPOSE 8080

RUN mkdir /data

CMD ["python3", "-m", "heroku"]
