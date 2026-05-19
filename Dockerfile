FROM maximhq/bifrost:latest

USER root
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update
RUN apk add --no-cache nodejs npm python3 py3-pip curl go
RUN python3 -m venv /opt/venv \
    && /opt/venv/bin/pip install --no-cache-dir uv

ENV GOPATH=/opt/go/ 
ENV PATH="/usr/local/bin:/usr/local/lib/node_modules/.bin:/opt/venv/bin:$GOPATH/bin:$PATH"

WORKDIR /app
RUN npm -g install typescript pyright yaml-language-server typescript-language-server bash-language-server @tailwindcss/language-server svelte-language-server dockerfile-language-server-nodejs vscode-json-languageserver
RUN go install golang.org/x/tools/gopls@latest
RUN curl -fsSL https://raw.githubusercontent.com/blackwell-systems/agent-lsp/main/install.sh | sh
RUN agent-lsp doctor