#//bin/bash
export VAULT_ADDR="http://127.0.0.1:8200"

# Make sure to have vault on your system before proceeding
command -v vault >/dev/null 2>&1 || { echo >&2 "I require vault but it's not installed.  Aborting."; exit 1; }
command -v jq >/dev/null 2>&1 || { echo >&2 "I require jq but it's not installed.  Aborting."; exit 1; }

VAULT_ROOT='addo2017rocksmysocks'
VAULT_USER_PASS='addo2017rocksfabian'

# login to vault as root to set up
vault auth ${VAULT_ROOT}

# write the policy into vault
vault policy-write vault_admin ./policies/vault_admin.hcl

# enable auth methods
vault auth-enable userpass
vault auth-enable approle

# make a new user 'fabian'
vault write auth/userpass/users/fabian policies=vault_admin password=${VAULT_USER_PASS}

# login to vault as fabian
vault auth -method=userpass username=fabian password=${VAULT_USER_PASS}
vault token-lookup

# Always revoke tokens for testing and printing out on screen
# TOKEN=$(vault token-lookup -format=json | jq -r .data.id)
# vault token-revoke ${TOKEN}
