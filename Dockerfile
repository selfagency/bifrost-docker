FROM maximhq/bifrost:latest

USER root
RUN apk add --no-cache nodejs npm python3 py3-pip
RUN python3 -m venv /opt/venv \
    && /opt/venv/bin/pip install --no-cache-dir uv

ENV PATH="/opt/venv/bin:${PATH}"