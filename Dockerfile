# FROM node:18.19-alpine3.19
# WORKDIR /mern-ecommerce/frontend/
# COPY frontend/public/ ./public/
# COPY frontend/src/ ./src/
# COPY frontend/package*.json .
# RUN npm install
# WORKDIR /mern-ecommerce/
# COPY backend/ ./backend/
# COPY package*.json .
# COPY uploads/ ./uploads/
# RUN npm install
# ENV MONGO_URI=mongodb+srv://hamza3256:Anonymous3256@adamjeedata.3u43k.mongodb.net/?retryWrites=true&w=majority
# ENV NODE_ENV=development
# ENV PORT=5000
# ENV PAYPAL_CLIENT_ID=AZ7zNz4n-q1XycSTqtPBnLQgtkUNk4wPxhhKHFSZpxc6YJb2vGtFKyKUa8y4D8yrWc8ubHhItlrI38zk
# ENV JWT_SECRET=Anonymous3256
# RUN npm run data-import
# EXPOSE 3000
# CMD ["npm", "run", "dev"]

FROM node:16-alpine as builder
WORKDIR /mern-ecommerce/frontend/
COPY frontend/public/ ./public/
COPY frontend/src/ ./src/
COPY frontend/package*.json .
RUN npm install
RUN npm run build
WORKDIR /mern-ecommerce/
COPY backend/ ./backend/
COPY package*.json .
COPY uploads/ ./uploads/
RUN npm install
ENV MONGO_URI=mongodb+srv://hamza3256:Anonymous3256@adamjeedata.3u43k.mongodb.net/?retryWrites=true&w=majority
ENV NODE_ENV=development
ENV PORT=5000
ENV PAYPAL_CLIENT_ID=AZ7zNz4n-q1XycSTqtPBnLQgtkUNk4wPxhhKHFSZpxc6YJb2vGtFKyKUa8y4D8yrWc8ubHhItlrI38zk
ENV JWT_SECRET=Anonymous3256
RUN npm run data-import
# EXPOSE 3000
CMD ["npm", "run", "dev"]

FROM nginx:1.19.0
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /mern-ecommerce/frontend/build .
ENTRYPOINT ["nginx", "-g", "daemon off;"]