FROM node:16-alpine

RUN mkdir -p /usr/src/app/
WORKDIR /usr/src/app/

COPY . /usr/src/app/

RUN npm i --force
RUN npm install -g concurrently
# RUN npm run server
RUN apk add --no-cache tzdata
ENV TZ="Europe/Kiev"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
EXPOSE 9092

CMD ["concurrently", "npm:server", "npm:local"]
# build image: sudo docker build -t webpack . 
# run container: sudo docker run -p 9092:9092 -e TZ=Europe/Kiev -v /home/olegann/JS/Vue/eng_DI_09_10:/usr/src/app  webpack 

# FROM node:16-alpine

# # Install system dependencies for this package.
# RUN apk add --no-cache imagemagick

# # Create app directory
# WORKDIR /usr/src/app

# # Bundle app source
# COPY . .

# RUN npm ci \
#     # Install server and generator.
#     && npm run postinstall \
#     # Write entrypoint.
#     && printf "ls\nnpm run server\nnpm run local\n" > entrypoint.sh

# EXPOSE 3050
# EXPOSE 3055

# CMD ["/bin/sh", "entrypoint.sh"]