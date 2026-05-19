FROM maximhq/bifrost:latest

USER root
RUN apk add --no-cache nodejs npm python3 py3-pip curl
RUN python3 -m venv /opt/venv \
    && /opt/venv/bin/pip install --no-cache-dir uv
RUN npm -g install typescript pyright yaml-language-server typescript-language-server bash-language-server @tailwindcss/language-server svelte-language-server @stylelint/language-server 
RUN curl -fsSL https://raw.githubusercontent.com/blackwell-systems/agent-lsp/main/install.sh | sh

ENV PATH="/opt/venv/bin:${PATH}"