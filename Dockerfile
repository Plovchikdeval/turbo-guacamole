FROM ubuntu:latest
ENV SHARKHOST=true
WORKDIR /Foxuserbot
COPY . /Foxuserbot

RUN apt-get update && apt-get install -y python3 python3-pip python3-venv wget unzip curl openssh-client
RUN python3 -m venv venv
RUN . venv/bin/activate && pip install --upgrade pip
# Копируем скрипт запуска
COPY fox /Foxuserbot/fox.sh

# Делаем его исполняемым
RUN chmod +x /Foxuserbot/fox.sh

# Обновляем команду запуска
CMD ["/Foxuserbot/fox.sh"]
