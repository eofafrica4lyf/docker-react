FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
run npm install
COPY . .
RUN npm run build

#second phase; nginx automatically starts up, so we don't have to specify a start command for it.
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
