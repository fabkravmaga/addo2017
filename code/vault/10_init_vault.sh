#!/bin/bash
set -e

read -p "Running this script will initialize & unseal Vault, then put your unseal keys and root token in the file /tmp/vault.init. If you're sure you want to continue, type 'yes': `echo '> '`" ANSWER

if [ "$ANSWER" != "yes" ]; then
  echo
  echo "Exiting without intializing & unsealing Vault, no keys or tokens were stored."
  echo
  exit 1
fi

if [ -e "/tmp/vault.init" ]; then
  echo "Vault has already been initialized, skipping."
  
else
  echo "Initialize Vault"
  vault operator init | tee /tmp/vault.init > /dev/null

  export ROOT_TOKEN=$(cat /tmp/vault.init | grep '^Initial' | awk '{print $4}')

  echo "Remove master keys from disk"
  echo "Setup Vault demo"
fi

echo "Unsealing Vault"

COUNTER=1
cat /tmp/vault.init | grep '^Unseal' | awk '{print $4}' | for key in $(cat -); do
  vault unseal $key
  COUNTER=$((COUNTER + 1))
done

echo "Vault setup complete."

instructions() {
  cat <<EOF
We use an instance of HashiCorp Vault for secrets management.
It has been automatically initialized and unsealed once. Future unsealing must
be done manually.
The unseal keys and root token have been temporarily stored in the VM.
Please securely distribute and record these secrets and remove them asap.
EOF

  exit 1
}

instructions
