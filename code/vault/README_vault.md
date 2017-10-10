# README Vault Setup

The `policies` folder contains the policies needed to administer the basic vault set up like a vault admin, and an example approle.

This folder contains scripts that allows you to run a developement version of HashiCorp Vault (along with a graphical UI) locally on your machine using Docker.

The scripts are named in a numeric way which corresponds with the order of execution.

===

First, create a file i.e. `touch .secret0` with contents:

```
#!/bin/bash
export VAULT_ADDR='https://127.0.0.1:8200'
export VAULT_DEV_ROOT_TOKEN_ID=''
export VAULT_USERNAME=''
export VAULT_PASSWORD=''
```

Source the file `source ./secret0`.

Run scripts in order:

1. [`./0_update_requirements.sh`](./0_update_requirements.sh)

2. [`./1_start_server.sh`](./1_start_server)

3. [`./2_ready_userpass.sh`](./2_ready_userpass.sh)

4. [`./3_ready_approle.sh`](./3_ready_approle.sh)

5. [`./4_test_approle.sh`](./4_test_approle.sh)

6. [`./5_start_ui.sh`](./5_start_ui.sh)


To shutdown all vault services, run:

1. [`./99_shutdown_all.sh`](./99_shutdown_all.sh)


When you fully understand what the scripts are doing, and is lazy, run all scripts at once using:

1. [`./lazy_start_all.sh`](./lazy_start_all.sh)

===

Read more about [Vault environment variables](https://www.vaultproject.io/docs/commands/environment.html)
