FROM python:3.10-slim

ENV POETRY_VENV=/app/.venv

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get -qq update \
    && apt-get -qq install --no-install-recommends \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m venv $POETRY_VENV \
    && $POETRY_VENV/bin/pip install -U pip setuptools \
    && $POETRY_VENV/bin/pip install poetry

ENV PATH="${PATH}:${POETRY_VENV}/bin"

ENV ASR_MODEL=base

WORKDIR /app

COPY ./cache /root/.cache/whisper

COPY ./app /app

RUN poetry config virtualenvs.in-project true
RUN poetry install
CMD [ "whisper", "foo", "--language", "en", "--fp16" "False", "--verbose" "False", "--output_format", "txt" ]