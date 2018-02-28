docker build -t vuulrnetstats .

docker run -d -p 3000:3000 --name=ethereum-netstats vuulrnetstats

