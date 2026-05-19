FROM maximhq/bifrost:latest

USER root

RUN apk add --no-cache --virtual .build-deps bash gcc musl-dev openssl go
RUN apk add --no-cache nodejs npm python3 py3-pip curl
RUN python3 -m venv /opt/venv \
    && /opt/venv/bin/pip install --no-cache-dir uv
RUN wget -O go.tgz https://dl.google.com/go/go1.26.3.src.tar.gz 
RUN tar -C /usr/local -xzf go.tgz 

WORKDIR /usr/local/go/src/ 
RUN ./make.bash 
ENV GOPATH=/opt/go/ 
ENV PATH="/usr/local/bin:/usr/local/go/bin:/usr/local/lib/node_modules/.bin:/opt/venv/bin:$GOPATH/bin:$PATH"

WORKDIR /app
RUN go version
RUN npm -g install typescript pyright yaml-language-server typescript-language-server bash-language-server @tailwindcss/language-server svelte-language-server dockerfile-language-server-nodejs vscode-json-languageserver
RUN go install golang.org/x/tools/gopls@latest
RUN curl -fsSL https://raw.githubusercontent.com/blackwell-systems/agent-lsp/main/install.sh | sh
RUN agent-lsp doctor
RUN apk del .build-deps 