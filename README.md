# All Day DevOps (ADDO) 2017

All Day DevOps 2017 Materials

[VIEW SLIDES HERE](https://docs.google.com/presentation/d/1OiJD24-Mn4zoDZaDnAdl5bRfFsy_YmxZUdGuAhzuWZM/edit?usp=sharing)

Simple Developer's All-In-One-Machine CICD Pipeline

Steps:

1. Run bash scripts in order of the numbers in the `./code/vault` folder

2. Manage Secrets from UI / CLI

3. Run bash script in `./code/app` folder to start app

4. Build Secure Pipeline

5. Rejoice =)

## Likely Benefits of using a Secret Management Service

1. Secrets are managed centrally

2. Secrets can be rotated easily

3. Compromised secrets can be revoked, and rotated easily

4. Lowers the risk of exposing valid secrets because secrets can be revoked and rotated immediately when:
  1. developers lose a machine that contains secrets
  2. when secrets are accidentally checked into source code repository

5. Secret management server issues secrets only to authorized developers through user policies and management

6. Authorized developers can retrieve the latest secrets through API calls and not ask fellow developers

7. Audit log of the retrieval of secrets

8. One-time unwrap feature can ensure tokens are read once (HashiCorp Vault)

## References:

* Vault Binary - https://vaultproject.io

* Vault Docker Image - https://hub.docker.com/_/vault/

* Vault UI - https://github.com/djenriquez/vault-ui

* CRUD Web App Instructions - https://zellwk.com/blog/crud-express-mongodb/

* Dockerize NodeJS app - https://nodejs.org/en/docs/guides/nodejs-docker-webapp/
