FROM node:22-alpine
WORKDIR /app

# Copiar arquivos de configuração
COPY package*.json ./
COPY tsconfig.json ./

# Instalar dependências SEM scripts (evita erro do rename)
RUN npm install --ignore-scripts

# Copiar código fonte
COPY . .

# Build apenas TypeScript
RUN npx tsc

# Renomear manualmente .js para .cjs (compatível Alpine)
RUN find build -type f -name "*.js" | while read file; do \
    mv "$file" "${file%.js}.cjs"; \
    done

# MCP roda via stdio
#CMD ["node", "build/server.cjs"]

#Isso mantém o container ativo sem consumir CPU
CMD ["tail", "-f", "/dev/null"]

