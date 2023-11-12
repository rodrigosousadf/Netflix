# Use a imagem Node.js 14 com Alpine Linux como base
FROM node:14-alpine

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia apenas os arquivos necessários para a construção do projeto (package.json e package-lock.json primeiro)
COPY package*.json ./

# Instala as dependências
RUN npm install

# Copia o restante dos arquivos do aplicativo
COPY . .

# Executa o comando 'npm run build' para construir o aplicativo Next.js
RUN npm run build

# Exponha a porta 3000 (ou a porta que você usa em seu aplicativo Next.js)
EXPOSE 3000

# Comando a ser executado quando o contêiner for iniciado
CMD ["npm", "start"]
