#!/bin/bash
export VAULT_ADDR="http://127.0.0.1:8200"

# Make sure to have vault on your system before proceeding
command -v vault >/dev/null 2>&1 || { echo >&2 "I require vault but it's not installed.  Aborting."; exit 1; }

vault policy-write example_r ./policies/example_r.hcl
vault policy-write example_rw ./policies/example_rw.hcl
vault policy-write example_approle_admin ./policies/example_approle_admin.hcl

vault write auth/approle/role/example \
  secret_id_ttl=10m \
  token_ttl=10m \
  token_max_ttl=30m \
  secret_id_num_uses=3 \
  policies=example_r

# write a set of key value into path 'app/example/addo'
vault write secret/example/test service=test_service username=test_username password=test_password
