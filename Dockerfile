FROM node:22-alpine
WORKDIR /app

# Copiar package files
COPY package*.json ./

# Instalar dependências SEM rodar scripts (evita erro do rename)
RUN npm install --ignore-scripts

# Copiar código fonte
COPY . .

# Build APENAS TypeScript (sem rename)
RUN npx tsc

# MCP roda via stdio, não precisa EXPOSE
CMD ["node", "build/index.js"]
