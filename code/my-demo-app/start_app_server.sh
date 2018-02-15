#!/bin/sh
# README
# This is where a developer integrates this simple script
# to retrieve the necessary token as THE APP (not as a human user)

# Make sure to have vault on your system before proceeding
command -v vault >/dev/null 2>&1 || { echo >&2 "I require vault but it's not installed.  Aborting."; exit 1; }

SECRET_PATH='secret/example/mongodb'
echo "VAULT_USERNAME: $VAULT_USERNAME"
echo "VAULT_ADDR: $VAULT_ADDR"

: "${VAULT_ADDR?Need to set your VAULT_ADDR, usually 'export VAULT_ADDR=http://127.0.0.1:8200'}"
: "${VAULT_USERNAME?Need to set your VAULT_USERNAME}"
: "${VAULT_PASSWORD?Need to set your VAULT_PASSWORD}"

# login as a human user!
echo -e "hi! ${VAULT_USERNAME}"
vault auth -method=userpass username=${VAULT_USERNAME} password=${VAULT_PASSWORD} || exit

echo -e ""
echo -e "._ _  |  _    o  _|"
echo -e "| (_) | (/_   | (_|"
echo -e ""

ROLE_ID=$(vault read -field=role_id auth/approle/role/example/role-id)
echo -e "ROLE_ID: ${ROLE_ID} (not a secret; like a USERNAME for app)"

sleep 3

echo -e ""
echo -e "     ._ _. ._  ._   _   _|   _|_  _  |   _  ._  "
echo -e "\/\/ | (_| |_) |_) (/_ (_|    |_ (_) |< (/_ | | "
echo -e "           |   |                                "
echo -e ""

# This wrapped token is like a parcel
WRAPPED_TOKEN=$(vault write -f \
                  -field=wrapping_token \
                  -wrap-ttl=60s \
                  auth/approle/role/example/secret-id)

echo -e "WRAPPED_TOKEN: ${WRAPPED_TOKEN}"
echo -e "\n  WRAPPED_TOKEN is like a password wrapped in a parcel, delivered to the app."
echo -e "The WRAPPED_TOKEN can only be unwrapped ONCE."
echo -e "\nAfter being unwrap, this WRAPPED_TOKEN expires and is no longer valid anymore for further unwrap. \nLike a parcel can only be unwrapped once by the receiver."
echo -e "\nIf unwrapping fails, this WRAPPED_TOKEN is likely to be unwrapped or expired."
echo -e "\nLike a damaged or expired parcel delivered to the receiver, it should alert the delivery system (vault), and request for an exchange."

sleep 3



echo -e ""
echo -e " _  _   _ ._ _ _|_   o  _|"
echo -e "_> (/_ (_ | (/_ |_   | (_|"
echo -e ""

SECRET_ID=$(vault unwrap -field=secret_id ${WRAPPED_TOKEN})
echo -e "SECRET_ID: ${SECRET_ID}"
echo -e "\nSECRET_ID is like a PASSWORD used to authenticate the app.\n"

sleep 3

echo -e ""
echo -e "  _                                 "
echo -e "_|_ o ._   _. |   _|_  _  |   _  ._ "
echo -e " |  | | | (_| |    |_ (_) |< (/_ | |"
echo -e ""

echo -e "\nPairing ROLE_ID and SECRET_ID, we now authenticate the app.\n"

FINAL_TOKEN=$(vault write -field=token \
                auth/approle/login \
                role_id=${ROLE_ID} \
                secret_id=${SECRET_ID})

echo -e "FINAL_TOKEN: ${FINAL_TOKEN}"

# READ SECRET!
export MONGODB_CREDENTIALS=$(vault read -field=url ${SECRET_PATH})
# echo -e "\nmongoURL: ${MONGODB_CREDENTIALS}"

# Revoke! dont need the token anymore!
echo -e ""
echo -e "._ _      _  |   _  "
echo -e "| (/_ \/ (_) |< (/_ "
echo -e ""
echo -e "Once secrets are retrieved, app doesn't need the token anymore! REVOKE!"
vault token-revoke ${FINAL_TOKEN}

# finally, run the app in dev mode...
npm run dev
