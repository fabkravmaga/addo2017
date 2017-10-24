![All Day DevOps 2017](./doc/ADDO_logo_horizontal.png "All Day DevOps 2017")

> by @3jmaster

# Remove Developers’ Shameful Secrets

### [All DAY DEVOPS 2017 SLIDES HERE](https://docs.google.com/presentation/d/1OiJD24-Mn4zoDZaDnAdl5bRfFsy_YmxZUdGuAhzuWZM/edit?usp=sharing)

### [POST-CONFERENCE BLOG POST HERE](.)

***

## Follow Along All-In-One-Local-Machine CICD Pipeline

### Notes / Pre-Requisites for Running Demo Scripts:

1. Scripts were written on MacOS machine, please modify as needed for your environment

2. Ability to run [`vault`](https://www.vaultproject.io/downloads.html), [`docker`](https://docs.docker.com/engine/installation/), [`npm`](https://www.npmjs.com/get-npm) on your local machine

3. Basic general knowledge of Docker, HashiCorp Vault, GitLab, GitHub, MongoDB, CICD, bash, etc...

## Steps for Local Machine:

1. Run bash scripts in numeric order in `./code/vault` folder, [more instructions here](./code/vault/README.md)

2. Manage Secrets from Vault-UI (`http://localhost:80`) on your browser or from your CLI (vault write ...)

3. Run bash script in `./code/my-demo-app/docker_build.sh` to build image locally

3. Run bash script in `./code/my-demo-app/docker_run.sh` to run image locally

4. View the web app on your browser: http://localhost:3000

5. Cheers!

  ```
  ~  ~
  ( o )o)
  ( o )o )o)
  (o( ~~~~~~~~o
  ( )' ~~~~~~~'
  ( )|)       |-.
  o|     _  |-. \
  o| |_||_) |  \ \
  | | ||_) |   | |
  o|        |  / /
  |        |." "
  |        |- '
  .========.   mb
  ```

## Steps for Live Environment:

1. My Demo App @ http://13.228.110.97:3000/

    * Mark your presence! Submit your name and a quote! :)

2. Vault-UI @ http://13.228.110.97/

    * Try it using low-risk, read-only credentials user:addo2017 and password:addo2017

    * Permissions to see `secret/example/test` and `secret/example/mongodb-read`

3. Merging any changes into master branch will get the changes to be live

### Likely Benefits of using a Secret Management Service

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

### References:

* Vault Binary - https://vaultproject.io

* Vault Docker Image - https://hub.docker.com/_/vault/

* Vault UI - https://github.com/djenriquez/vault-ui

* CRUD Web App Instructions - https://zellwk.com/blog/crud-express-mongodb/

* Dockerize NodeJS app - https://nodejs.org/en/docs/guides/nodejs-docker-webapp/
