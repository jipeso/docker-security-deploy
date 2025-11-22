FROM node:20-alpine AS build-stage

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build

FROM nginxinc/nginx-unprivileged:alpine-slim

COPY --from=build-stage /app/dist /usr/share/nginx/html

EXPOSE 8080

USER nginx
