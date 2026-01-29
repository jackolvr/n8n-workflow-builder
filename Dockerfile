FROM node:22-alpine
WORKDIR /app

# Copiar package files
COPY package*.json ./

# Instalar dependências
RUN npm install

# Copiar código fonte
COPY . .

# Build (vai funcionar no Alpine sem problemas)
RUN npm run build

# MCP roda via stdio, não precisa EXPOSE
CMD ["node", "build/index.js"]
