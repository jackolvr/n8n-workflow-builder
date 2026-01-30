FROM node:22-alpine

# Instalar tini (init system leve)
RUN apk add --no-cache tini

WORKDIR /app

COPY package*.json ./
COPY tsconfig.json ./

RUN npm install --ignore-scripts

COPY . .

RUN npx tsc

# Rename .js -> .cjs
RUN for file in build/*.js; do \
    [ -f "$file" ] && mv "$file" "${file%.js}.cjs"; \
    done

# Usar tini como entrypoint (gerencia sinais e processos órfãos)
ENTRYPOINT ["/sbin/tini", "--"]

# Manter container vivo
CMD ["tail", "-f", "/dev/null"]
