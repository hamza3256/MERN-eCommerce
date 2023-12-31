FROM node:12-alpine
WORKDIR /mern-ecommerce/frontend/
COPY frontend/public /mern-ecommerce/frontend/public/
COPY frontend/src/ /mern-ecommerce/frontend/src/
COPY frontend/package.json /mern-ecommerce/frontend/
RUN npm install
WORKDIR /mern-ecommerce/
COPY backend/ /mern-ecommerce/backend/
COPY package.json /mern-ecommerce/
RUN npm install
CMD ["npm", "run", "dev"]