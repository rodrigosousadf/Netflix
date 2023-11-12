# Use uma imagem do Node.js
FROM node:14-alpine

# Defina o diretório de trabalho
WORKDIR /app

# Copie os arquivos de definição do pacote e o arquivo de bloqueio para o diretório de trabalho
COPY package*.json ./

# Instale as dependências (criará automaticamente o arquivo de lock)
RUN npm install --quiet

# Desative a auditoria temporariamente e execute npm audit fix
RUN npm set audit false && npm audit fix

# Copie todos os arquivos para o diretório de trabalho
COPY . .

# Execute o comando 'npm run build' para construir o aplicativo Next.js
RUN npm run build

# Exponha a porta 3000 (ou a porta que você usa em seu aplicativo Next.js)
EXPOSE 3000

# Comando para iniciar o aplicativo quando o contêiner for iniciado
CMD ["npm", "start"]
