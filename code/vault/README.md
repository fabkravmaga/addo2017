# README Vault Setup

The `policies` folder contains the policies needed to administer the basic vault set up like a vault admin, and an example approle.

This folder contains scripts that allows you to run a development version of HashiCorp Vault locally on your machine using Docker.

The scripts are named in a numeric way which corresponds with the order of execution.

***

Run scripts in order:

1. [`./0_update_requirements.sh`](./0_update_requirements.sh)

2. [`./1_start_server.sh`](./1_start_server.sh)

3. [`./10_init_vault.sh`](./10_init_vault.sh)

4.  `cat /tmp/vault.init` to view root token

5. Create a file: `touch .secret0`, and fill VAULT_DEV_ROOT_TOKEN_ID, VAULT_USERNAME and VAULT_PASSWORD with your own values:

    ```
    #!/bin/bash
    export VAULT_ADDR='https://127.0.0.1:8200'
    export VAULT_DEV_ROOT_TOKEN_ID='' # to fill in Initial Root Token here
    export VAULT_USERNAME='' # to fill in your own username
    export VAULT_PASSWORD='' # to fill in your own password
    ```

    *** This will be your secret0, precious root secret.***
  
6. [`source ./secret0`](.)

7. [`./2_ready_userpass.sh`](./2_ready_userpass.sh)

8. [`./3_ready_approle.sh`](./3_ready_approle.sh)

9. [`./4_test_approle.sh`](./4_test_approle.sh)

10. _OPTIONAL_ [`./5_start_ui.sh`](./5_start_ui.sh)

11. Put secrets into the Vault - i.e. mongodb url, etc.

To shutdown all vault services, run:

1. [`./99_shutdown_all.sh`](./99_shutdown_all.sh)


When you fully understand what the scripts are doing, and is lazy, run all scripts at once using:

1. [`./lazy_start_all.sh`](./lazy_start_all.sh)

2. View output here: `tail -f nohup.out`

***

Read more about [Vault environment variables](https://www.vaultproject.io/docs/commands/environment.html)
