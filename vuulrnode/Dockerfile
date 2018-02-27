FROM ethereum/client-go:v1.7.3

RUN apk update
RUN apk upgrade
RUN apk add git bash nodejs-npm

RUN git clone https://github.com/cubedro/eth-net-intelligence-api ~/


RUN cd ~/ && npm install && npm install -g pm2
COPY src/ /root/

#RUN cd ~/ && pm2 start ~/netstats-app.json


#RUN git clone https://github.com/ethersphere/eth-utils ~/
#RU cd ~/eth-utils && bash netstatconf.sh 1 vuulrchain-node http://172.21.0.6:3000 VUULR1234 > ../app.json
#cd ..
#EDIT
#cd eth-net-intelligence-api


#
#RUN cd ~/eth-net-intelligence-api


RUN echo "/usr/bin/pm2 start ~/netstats-node1.json" >> /root/run.sh && chmod a+x /root/run.sh

ENTRYPOINT ["geth"]
