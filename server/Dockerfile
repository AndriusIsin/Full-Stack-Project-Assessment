FROM node:20-alpine
WORKDIR /server
ADD package*.json ./
RUN npm install
ADD server.js ./
CMD [ "node", "server.js"]
