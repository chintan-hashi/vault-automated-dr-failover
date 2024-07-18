#!/usr/bin/env bash
# Usage: 
# ./setup_dr_operation_token.sh <vault_primary_cluster_addr> <vault_primary_cluster_token>

# Usage examples: 

# ./generate_dr_operation_token.sh 'https://vault.acme.com:8200' 'TVOp75iBx4SRICJ+LuSOvRjn34RPZOEv95dscMHTqow='
# ./generate_dr_operation_token.sh $VAULT_ADDR $VAULT_TOKEN


VAULT_ADDR_PRIMARY=$1
VAULT_PRIMARY_TOKEN=$2


VAULT_DR_OP_TOKEN=$(VAULT_TOKEN=$VAULT_PRIMARY_TOKEN vault token create \
    -field=token -role=failover-handler -ttl=24h)


echo "DR_OPERATION_TOKEN=${VAULT_DR_OP_TOKEN}"
echo $VAULT_DR_OP_TOKEN > dr_operation_token.value
