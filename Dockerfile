#Stage 1
FROM node:17-alpine as buider
WORKDIR /app
COPY package*.json .
RUN npm install
COPY . .
RUN npm run build

#Stage 2
FROM nginx:1.19.0
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=buider /app/dist .
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]