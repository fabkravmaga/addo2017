#!/bin/sh
# README
# This is where a developer integrates this simple script
# to retrieve the necessary token as THE APP (not as a human user)

# Make sure to have ./etc/vault on your system before proceeding
command -v ./etc/vault >/dev/null 2>&1 || { echo >&2 "I require ./etc/vault but it's not installed.  Aborting."; exit 1; }

SECRET_PATH='secret/example/mongodb'
echo "VAULT_USERNAME: $VAULT_USERNAME"
echo "VAULT_ADDR $VAULT_ADDR"
: "${VAULT_ADDR?Need to set your VAULT_ADDR, usually 'export VAULT_ADDR=http://127.0.0.1:8200'}"
: "${VAULT_USERNAME?Need to set your VAULT_USERNAME}"
: "${VAULT_PASSWORD?Need to set your VAULT_PASSWORD}"

# login as a human user!
echo -e "hi! ${VAULT_USERNAME}"
./etc/vault auth -method=userpass username=${VAULT_USERNAME} password=${VAULT_PASSWORD} || exit

ROLE_ID=$(./etc/vault read -field=role_id auth/approle/role/example/role-id)
echo -e "\n-------------------------ROLE_ID-----------------------------"
echo -e "ROLE_ID: ${ROLE_ID} (not a secret; like a USERNAME for app)"
echo -e "-------------------------ROLE_ID-----------------------------"
sleep 5

# This wrapped token is like a parcel
WRAPPED_TOKEN=$(./etc/vault write -f \
                  -field=wrapping_token \
                  -wrap-ttl=60s \
                  auth/approle/role/example/secret-id)

echo -e "\n-------------------------WRAPPED_TOKEN-----------------------------"
echo -e "WRAPPED_TOKEN: ${WRAPPED_TOKEN}"
echo -e "\n  WRAPPED_TOKEN is like a password wrapped in a parcel, delivered to the app."
echo -e "The WRAPPED_TOKEN can only be unwrapped ONCE."
echo -e "\nAfter being unwrap, this WRAPPED_TOKEN expires and is no longer valid anymore for further unwrap. \nLike a parcel can only be unwrapped once by the receiver."
echo -e "\nIf unwrapping fails, this WRAPPED_TOKEN is likely to be unwrapped or expired."
echo -e "\nLike a damaged or expired parcel delivered to the receiver, it should alert the delivery system (vault), and request for an exchange."
echo -e "-------------------------WRAPPED_TOKEN-----------------------------"
sleep 20

SECRET_ID=$(./etc/vault unwrap -field=secret_id ${WRAPPED_TOKEN})
echo -e "\n-------------------------SECRET_ID-----------------------------"
echo -e "SECRET_ID: ${SECRET_ID}"

echo -e "\n  SECRET_ID is like a PASSWORD used to authenticate the app.\n"
echo -e "-------------------------SECRET_ID-----------------------------"
sleep 5

echo -e "\n-------------------------FINAL_TOKEN-----------------------------"
echo -e "\n  Pairing ROLE_ID and SECRET_ID we now authenticate the app.\n"

FINAL_TOKEN=$(./etc/vault write -field=token \
                auth/approle/login \
                role_id=${ROLE_ID} \
                secret_id=${SECRET_ID})

echo -e "FINAL_TOKEN: ${FINAL_TOKEN}"
echo -e "-------------------------FINAL_TOKEN-----------------------------"
export MONGODB_CREDENTIALS=$(./etc/vault read -field=url ${SECRET_PATH})
# echo -e "\nmongoURL: ${MONGODB_CREDENTIALS}"

# dont need the token anymore!
echo -e "\n-------------------------REVOKE-----------------------------"
echo -e "Once secrets are retrieved, app doesn't need the token anymore! REVOKE!"
./etc/vault token-revoke ${FINAL_TOKEN}
echo -e "-------------------------REVOKE-----------------------------"

# finally, run the app to do development
npm run dev
