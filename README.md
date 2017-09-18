# addo2017
All Day DevOps 2017 Materials

[SLIDES HERE](https://docs.google.com/presentation/d/1OiJD24-Mn4zoDZaDnAdl5bRfFsy_YmxZUdGuAhzuWZM/edit?usp=sharing)

Simple All-In-One-Machine CICD Pipeline

Steps:

1. Run bash scripts in order of the numbers in the `./vault` folder

2. Manage Secrets from UI / CLI

3. Run bash script in `./app` folder to start app

4. Build Secure Pipeline

5. Rejoice =)

## Benefits

1. The app secrets do not retain on developers laptops

2. The app secrets are stored and have redundancy on a server that is maintained so other developers can retrieve the latest app secrets

3. The app secrets are easily rotated often by using a low TTL

4. Compromised app secrets are revoked easily, and developers can retrieve the latest app secrets easily

5. Apps can retrieve the tokens to

6. App secrets that are accidentally checked into source code can be made invalid immediately

## References:

* https://github.com/djenriquez/vault-ui

* https://hub.docker.com/_/vault/

* https://vaultproject.io

* CRUD Web App instructions from: https://zellwk.com/blog/crud-express-mongodb/
