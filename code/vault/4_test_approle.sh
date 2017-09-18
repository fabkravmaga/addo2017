#!/bin/bash
export VAULT_ADDR="http://127.0.0.1:8200"
export SECRET_PATH='secret/example/test'

# Make sure to have vault on your system before proceeding
command -v vault >/dev/null 2>&1 || { echo >&2 "I require vault but it's not installed.  Aborting."; exit 1; }

ROLE_ID=$(vault read -field=role_id auth/approle/role/example/role-id)
echo "ROLE_ID: ${ROLE_ID} (not a secret; like a USERNAME for app)"

WRAPPED_TOKEN=$(vault write -f \
                  -field=wrapping_token \
                  -wrap-ttl=60s \
                  auth/approle/role/example/secret-id)
echo "WRAPPED_TOKEN: ${WRAPPED_TOKEN} (one-time secret; like a wrapped up parcel containing a secret)"

SECRET_ID=$(vault unwrap -field=secret_id ${WRAPPED_TOKEN})
echo "SECRET_ID: ${SECRET_ID} (re-usable, revokable secret; like a PASSWORD for app)"

FINAL_TOKEN=$(vault write -field=token \
                auth/approle/login \
                role_id=${ROLE_ID} \
                secret_id=${SECRET_ID})
echo "FINAL_TOKEN: ${FINAL_TOKEN} (final, revokable secret that the app uses; like any token to use to call Vault API)"

echo -e "\nThese are the info on that the token that approle has:\n"
vault token-lookup ${FINAL_TOKEN}

echo -e "\nThese are the secrets that the approle can read:\n"
vault read ${SECRET_PATH}

echo -e "You can run curl:
          \n$ curl -H "X-VAULT-TOKEN: ${FINAL_TOKEN}" ${VAULT_ADDR}/v1/${SECRET_PATH}\n"

echo -e "to retrieve secrets in JSON format:\n"
curl --silent -H "X-VAULT-TOKEN: ${FINAL_TOKEN}" \
  ${VAULT_ADDR}/v1/${SECRET_PATH}

# Always Revoke test tokens
echo ""
vault token-revoke ${FINAL_TOKEN}
vault token-revoke ${SECRET_ID}
