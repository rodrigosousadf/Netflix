# Use uma imagem do Node.js
FROM node:14-alpine

# Defina o diretório de trabalho
WORKDIR /app

# Copie apenas os arquivos necessários para instalar as dependências
COPY package.json yarn.lock* ./

# Instale as dependências (criará automaticamente o arquivo de lock)
RUN npm install --quiet

# Copie todos os arquivos para o diretório de trabalho
COPY . .

# Execute o comando 'npm run build' para construir o aplicativo Next.js
RUN npm run build

# Exponha a porta 3000 (ou a porta que você usa em seu aplicativo Next.js)
EXPOSE 3000

# Comando para iniciar o aplicativo quando o contêiner for iniciado
CMD ["npm", "start"]
