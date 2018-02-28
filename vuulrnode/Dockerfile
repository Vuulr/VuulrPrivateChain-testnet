FROM ethereum/client-go:v1.7.3

RUN apk update
RUN apk upgrade
RUN apk add git bash nodejs-npm

RUN git clone https://github.com/cubedro/eth-net-intelligence-api ~/

RUN cd ~/ && npm install && npm install -g pm2
COPY src/ /root/

RUN echo "/usr/bin/pm2 start ~/netstats-node1.json" >> /root/run.sh && chmod a+x /root/run.sh

ENTRYPOINT ["geth"]
