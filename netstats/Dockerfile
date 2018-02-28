
# Chris Drumgoole | chris.drumgoole@vuulr.com | Vuulr.com
#
# Docker container definition for our ethereum netstats instance

FROM ubuntu

LABEL maintainer="chris.drumgoole@vuulr.com"

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y npm nodejs-legacy
RUN apt-get install -y git
RUN apt-get install -y curl

RUN npm install -g grunt
RUN npm install -g pm2


RUN git clone https://github.com/cubedro/eth-netstats /var/lib/eth-netstats
WORKDIR /var/lib/eth-netstats
RUN npm install
#RUN sudo npm install -g grunt-cli
RUN grunt all


ENTRYPOINT WS_SECRET=VUULR1234 npm start
