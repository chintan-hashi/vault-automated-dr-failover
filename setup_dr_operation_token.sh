#!/usr/bin/env bash
# Usage: 
# ./setup_dr_operation_token.sh <vault_primary_cluster_addr> <vault_primary_cluster_token>

# Usage examples: 

# ./setup_dr_operation_token.sh 'https://vault.acme.com:8200' 'TVOp75iBx4SRICJ+LuSOvRjn34RPZOEv95dscMHTqow='
# ./setup_dr_operation_token.sh $VAULT_ADDR $VAULT_TOKEN


VAULT_ADDR_PRIMARY=$1
VAULT_PRIMARY_TOKEN=$2



VAULT_TOKEN=$VAULT_PRIMARY_TOKEN vault policy write \
    dr-secondary-promotion - <<EOF
path "sys/replication/dr/secondary/promote" {
  capabilities = [ "update" ]
}

# To update the primary to connect
path "sys/replication/dr/secondary/update-primary" {
    capabilities = [ "update" ]
}
EOF

VAULT_TOKEN=$VAULT_PRIMARY_TOKEN vault policy list

VAULT_TOKEN=$VAULT_PRIMARY_TOKEN vault write auth/token/roles/failover-handler \
    allowed_policies=dr-secondary-promotion \
    orphan=true \
    renewable=false \
    token_type=batch

VAULT_DR_OP_TOKEN=$(VAULT_TOKEN=$VAULT_PRIMARY_TOKEN vault token create \
    -field=token -role=failover-handler -ttl=24h)

