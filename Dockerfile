# FROM node:12-alpine
# WORKDIR /mern-ecommerce/frontend/
# COPY frontend/public/ ./public/
# COPY frontend/src/ ./src/
# COPY frontend/package.json .
# RUN npm install
# WORKDIR /mern-ecommerce/
# COPY backend/ ./backend/
# COPY package.json .
# COPY uploads/ ./uploads/
# RUN npm install
# # RUN npm run data-import
# CMD ["npm", "run", "dev"]

FROM node:12-alpine as builder
WORKDIR /mern-ecommerce/frontend/
COPY frontend/public/ ./public/
COPY frontend/src/ ./src/
COPY frontend/package.json .
RUN npm install
WORKDIR /mern-ecommerce/
COPY backend/ ./backend/
COPY package.json .
COPY uploads/ ./uploads/
RUN npm install
RUN npm run build --prefix frontend

FROM nginx:1.19.0
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /mern-ecommerce/frontend/build .
ENTRYPOINT ["nginx", "-g", "daemon off;"]