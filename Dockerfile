FROM python:3.10-slim

ENV DOCKER=true

ENV DJ_HOST=true

ENV GIT_PYTHON_REFRESH=quiet



ENV PIP_NO_CACHE_DIR=1 \

    PYTHONUNBUFFERED=1 \

    PYTHONDONTWRITEBYTECODE=1



RUN apt update && apt install libcairo2 git build-essential -y --no-install-recommends

RUN rm -rf /var/lib/apt/lists /var/cache/apt/archives /tmp/*



RUN mkdir /data



RUN git clone https://github.com/Plovchikdeval/Heroku /Heroku

WORKDIR /Heroku



RUN pip install --no-warn-script-location --no-cache-dir -U -r requirements.txt



EXPOSE 8080



CMD python -m hikka
