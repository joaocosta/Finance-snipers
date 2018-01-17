#!/bin/sh

SNIPER_DIR=$HOME/src/Finance-snipers

docker rm -f signal-scan 2> /dev/null || true
docker run  \
    --restart=always \
    --name signal-scan \
    --link signal-scan-redis:signal-scan-redis \
    -h signal-scan.fxhistoricaldata.com \
    -v $SNIPER_DIR/bin:/root/snipers \
    -v $HOME/fxtrader.cfg:/etc/fxtrader \
    --log-driver=json-file \
    -d fxtrader/finance-hostedtrader \
    sh -c 'exec /usr/bin/perl /root/snipers/signal_check.pl'
