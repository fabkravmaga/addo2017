# README Vault Setup

The `policies` folder contains the policies needed to administer the basic vault set up like a vault admin, and an example approle.

The rest of the scripts are named in a numeric way such that it is in the order of execution.

Source the necessary environment variables and run in order:

1. `./0_update_requirements.sh`

2. `./1_start_server.sh`

3. `./2_ready_userpass.sh`

4. `./3_ready_approle.sh`

5. `./4_test_approle.sh`

6. `./5_start_ui.sh`


To shutdown all vault services, run:

1. `99_shutdown_all.sh`
