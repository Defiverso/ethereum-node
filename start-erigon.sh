#!/usr/bin/env bash
set -e

DATADIR="/home/erigon"

echo "Iniciando Erigon..."
exec erigon \
  --datadir "$DATADIR" \
  --chain=mainnet \
  --prune.mode=full \
  --http \
  --http.corsdomain="*" \
  --http.vhosts="*" \
  --http.addr=0.0.0.0 \
  --http.port=8545 \
  --http.api=eth,net,web3 \
  --ws \
  --ws.port=8546 
