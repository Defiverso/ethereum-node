#!/usr/bin/env bash
set -e

RPC_URL=${1:-http://localhost:8545}

echo "Monitorando sincronização do node em $RPC_URL..."
echo "Pressione Ctrl+C para sair."

while true; do
    response=$(curl -s -m 5 -X POST --data '{"jsonrpc":"2.0","method":"eth_syncing","params":[],"id":1}' \
               -H "Content-Type: application/json" "$RPC_URL" || true)
    curl_exit=$?

    if [ $curl_exit -ne 0 ] || [ -z "$response" ]; then
        echo -ne "\r[$(date)]: Aguardando RPC em $RPC_URL..."
        sleep 3
        continue
    fi

    if echo "$response" | grep -q '"result":false'; then
        echo -e "\r[$(date)]: Node completamente sincronizado "
        break
    else
        currentBlock=$(echo "$response" | sed -n 's/.*"currentBlock":"\([^"]*\)".*/\1/p' | head -n1)
        highestBlock=$(echo "$response" | sed -n 's/.*"highestBlock":"\([^"]*\)".*/\1/p' | head -n1)

        if [[ -z "$currentBlock" || -z "$highestBlock" || "$highestBlock" == "0x0" ]]; then
            echo -ne "\r[$(date)]: Inicializando sincronização..."
        else
            currentBlock=$((16#${currentBlock#0x}))
            highestBlock=$((16#${highestBlock#0x}))
            percent=$(( currentBlock * 100 / highestBlock ))
            echo -ne "\r[$(date)]: Sincronizando... $percent% (Bloco $currentBlock / $highestBlock)"
        fi
        # echo ""
        # echo "$response" | jq -r '.result.stages[] | "\(.stage_name): \(.block_number)"'
        
    fi
    sleep 3
done
