FROM node:alpine

# Create app directory
WORKDIR /usr/src

# Install app dependencies
COPY package.json .

RUN npm install

# Bundle app source
COPY . .

EXPOSE 3000

CMD [ "sh", "/usr/src/start_dev_pipeline.sh" ]
