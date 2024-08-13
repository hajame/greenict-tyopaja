FROM node:18.20.4-alpine3.20 AS builder

WORKDIR /deps
COPY package.json .
COPY package-lock.json .

RUN npm install --omit=dev

FROM node:18.20.4-alpine3.20
WORKDIR /usr/src/app
ENV NODE_ENV=production
EXPOSE 8080

COPY database.sqlite .
COPY --from=builder /deps/node_modules node_modules
COPY src .

CMD ["node", "index.js"]
