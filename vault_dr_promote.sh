#!/usr/bin/env bash
# Usage: 
# ./vault_dr_promote.sh <vault_secondary_cluster_addr> <dr_operation_token>

# Usage examples: 

# ./vault_dr_promote.sh 'https://vault-dr.acme.com:8200' 'TVOp75iBx4SRICJ+LuSOvRjn34RPZOEv95dscMHTqow='
# ./vault_dr_promote.sh $VAULT_ADDR $VAULT_DR_TOKEN


VAULT_ADDR=$1
VAULT_DR_OPERATION__TOKEN=$2

vault write -f sys/replication/dr/secondary/promote \
    dr_operation_token=$VAULT_DR_OPERATION__TOKEN
