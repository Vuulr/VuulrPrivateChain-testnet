
# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
#
# Docker container definition for our ethereum explorer instance


FROM ubuntu

LABEL maintainer="chris.drumgoole@vuulr.com"

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y npm nodejs-legacy git curl bash vim lynx

RUN cd ~/ && git clone https://github.com/carsenk/explorer

WORKDIR /root/explorer

COPY src/app.js /root/explorer/app/
COPY src/package.json /root/explorer/

#RUN cp config.js.example config.js

RUN npm install

RUN npm install -g bower
RUN bower --allow-root install


#COPY . .

EXPOSE 8000

#CMD [ "npm", "start" ]
ENTRYPOINT npm start


#EXPOSE 3001
