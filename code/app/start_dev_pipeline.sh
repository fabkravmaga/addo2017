#!/bin/bash
# README
# This is where a developer integrates this simple script
# to retrieve the necessary token as THE APP (not as a human user)

# Make sure to have vault on your system before proceeding
command -v vault >/dev/null 2>&1 || { echo >&2 "I require vault but it's not installed.  Aborting."; exit 1; }

export VAULT_ADDR="http://127.0.0.1:8200"
export VAULT_USERNAME='fabian'
export SECRET_PATH='secret/example/mongodb'

# login as a human user!
echo -e "vault login:"
echo -e "username ${VAULT_USERNAME}"
vault auth -method=userpass username=${VAULT_USERNAME}

ROLE_ID=$(vault read -field=role_id auth/approle/role/example/role-id)
echo "ROLE_ID: ${ROLE_ID} (not a secret; like a USERNAME for app)"

# This wrapped token is like a parcel
WRAPPED_TOKEN=$(vault write -f \
                  -field=wrapping_token \
                  -wrap-ttl=60s \
                  auth/approle/role/example/secret-id)

echo -e "Retrieved WRAPPED_TOKEN, this WRAPPED_TOKEN is like a password wrapped in a parcel, delivered to the app."
echo -e "The WRAPPED_TOKEN can only be unwrapped ONCE."
echo -e "After being unwrap, this WRAPPED_TOKEN expires and is no longer valid anymore for further unwrap. \nLike a parcel can only be unwrapped once by the receiver."
echo -e "If unwrapping fails, this WRAPPED_TOKEN is likely opened previously and its confidentiality is not guaranteed. \nLike a damaged parcel delivered to the receiver, it should alert the delivery system, and request for an exchange."

SECRET_ID=$(vault unwrap -field=secret_id ${WRAPPED_TOKEN})
echo -e "Retrieved SECRET_ID, this SECRET_ID is like a password specifically used to authenticate the application."

FINAL_TOKEN=$(vault write -field=token \
                auth/approle/login \
                role_id=${ROLE_ID} \
                secret_id=${SECRET_ID})

export MONGODB_CREDENTIALS=$(vault read -field=url ${SECRET_PATH})
# echo -e "\nmongoURL: ${MONGODB_CREDENTIALS}"

# finally, run the app to do development
npm run dev
