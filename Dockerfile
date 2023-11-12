# Use uma imagem oficial do Node.js como base
FROM node:14

# Defina o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copie o arquivo package.json para o diretório de trabalho
COPY package*.json ./

# Instale as dependências
RUN npm install

# Copie todo o código-fonte para o diretório de trabalho
COPY . .

# Exponha a porta 8080
EXPOSE 8080

# Comando para iniciar o aplicativo quando o contêiner for iniciado
CMD ["npm", "start"]
