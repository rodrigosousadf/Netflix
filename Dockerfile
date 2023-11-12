FROM node:14-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install --quiet

COPY . .

# Audit de segurança
RUN npm audit --audit-level=high

# Correção automática de algumas vulnerabilidades
RUN npm audit fix

# Construção do aplicativo Next.js
RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]
