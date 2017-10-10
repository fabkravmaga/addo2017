FROM node:alpine

# Create app directory
WORKDIR /usr/src

# Install app dependencies
COPY package.json .

RUN npm install

# Bundle app source
COPY . .

EXPOSE 3000

CMD [ "./start_app_start.sh"]
