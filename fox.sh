#!/bin/bash
set -e

MARKER_FILE=".git_pulled_once"

# Проверяем, делали ли git pull ранее
if [ ! -f "$MARKER_FILE" ] && [ -d .git ]; then
    echo "First start detected — pulling from git..."
    git pull || echo "git pull failed, continuing anyway"
    touch "$MARKER_FILE"
else
    echo "Skipping git pull — already done."
fi

# Запускаем основное приложение
exec python3 main.py
