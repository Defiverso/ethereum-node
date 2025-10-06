# Nó Ethereum com Erigon (Docker)

Este repositório contém uma configuração simples para rodar um nó Ethereum (mainnet) usando o cliente Erigon em contêiner Docker.

## Visão geral
- **Cliente**: Erigon
- **Rede**: Mainnet
- **Persistência**: Volume local mapeado para `./data`

## Como clonar este repositório
Para obter o código localmente, execute:
```bash
git clone https://github.com/Defiverso/ethereum-node.git
cd ethereum-node
```
## Requisitos
- Docker (20+ recomendado)
- Docker Compose (v2)
- `bash`
- `curl`
## Como iniciar
1. Dê permissão de execução aos scripts (apenas uma vez):
   ```bash
   chmod +x start-erigon.sh verify-sync.sh
   ```
2. Suba o serviço:
   ```bash
   docker compose up -d
   ```
3. Acompanhe os logs (opcional):
   ```bash
   docker logs -f erigon-mainnet
   ```

O Erigon expõe:
- HTTP RPC: `http://localhost:8545`
- WebSocket: `ws://localhost:8546`
- P2P: `30303` (TCP/UDP)

Os dados do nó ficam em `./data` no host e em `/home/erigon` no container.

## Usar com MetaMask
Siga os passos abaixo para conectar o MetaMask ao seu nó local (mainnet):

1. Abra o MetaMask e vá em Configurações > Redes > Adicionar rede manualmente.
2. Preencha os campos:
   - Nome da rede: `Mainnet (Local)`
   - URL RPC: `http://localhost:8545`
   - Chain ID: `1`
   - Símbolo da moeda: `ETH`
   - URL do explorador de blocos (opcional): `https://etherscan.io`
3. Salve e selecione a rede criada.

Observações:
- O MetaMask já possui a "Ethereum Mainnet". Você pode criar uma rede personalizada com o mesmo Chain ID (1) apontando para seu RPC local.
- Alternativamente, mantenha a rede "Ethereum Mainnet" padrão no MetaMask e configure suas DApps/SDKs para usar `http://localhost:8545` como provedor RPC.

## Parar e remover
- Parar o serviço:
  ```bash
  docker compose stop
  ```
- Remover containers (mantendo dados em `./data`):
  ```bash
  docker compose down
  ```

## Notas e segurança
- As portas `8545`, `8546` e `30303` ficam expostas localmente. Não exponha publicamente sem firewall.
- O diretório `./data` pode ficar grande. Garanta espaço em disco suficiente.

## Solução de problemas
- Permissão negada ao subir:
  ```bash
  chmod +x start-erigon.sh verify-sync.sh
  ```
- Baixo desempenho de I/O: prefira discos SSD NVMe para `./data`.
- Reset total de dados (irá re-sincronizar do zero):
  ```bash
  docker compose down
  rm -rf ./data
  docker compose up -d
  ```

## Licença
Distribuído sob a licença MIT.
