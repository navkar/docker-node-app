## docker commands

```bash
docker build -t naveen/my-node-app:1.0 .

HundredMillion:node-image navkar$ docker images
REPOSITORY           TAG       IMAGE ID       CREATED          SIZE
naveen/my-node-app   1.0       5ec8476765d1   12 seconds ago   173MB
HundredMillion:node-image navkar$ docker image ls 
REPOSITORY           TAG       IMAGE ID       CREATED          SIZE
naveen/my-node-app   1.0       5ec8476765d1   16 seconds ago   173MB
```

### docker login

```bash
$ docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: navkar
Password: 
Login Succeeded
```

### docker run

```bash
$ docker run -p 7777:8080 -d naveen/my-node-app:1.0
ad8a240e2757d37a69d3aeb2ca5c33b2a214faf0f172071f1802a3149769f752
HundredMillion:node-image navkar$ docker ps
CONTAINER ID   IMAGE                    COMMAND                  CREATED          STATUS          PORTS                    NAMES
ad8a240e2757   naveen/my-node-app:1.0   "docker-entrypoint.s…"   23 seconds ago   Up 22 seconds   0.0.0.0:7777->8080/tcp   vibrant_borg
```

## references

[nodejs-docker-webapp](https://nodejs.org/en/docs/guides/nodejs-docker-webapp/#dockerignore-file)
[Generate the SBOM for Docker images](https://docs.docker.com/engine/sbom/)

### Docker sbom (software bill of materials)

```bash
docker sbom neo4j:4.4.5
```

### Docker scan

```bash
HundredMillion:node-image navkar$ docker scan --accept-license --version
Version:    v0.17.0
Git commit: 061fe0a
Provider:   Snyk (1.827.0)
HundredMillion:node-image navkar$ docker scan naveen/my-node-app:1.0
Docker Scan relies upon access to Snyk, a third party provider, do you consent to proceed using Snyk? (y/N)
y

Testing naveen/my-node-app:1.0...

Package manager:   apk
Project name:      docker-image|naveen/my-node-app
Docker image:      naveen/my-node-app:1.0
Platform:          linux/amd64
Base image:        node:18.8.0-alpine3.16

✔ Tested 16 dependencies for known vulnerabilities, no vulnerable paths found.

According to our scan, you are currently using the most secure version of the selected base image

For more free scans that keep your images secure, sign up to Snyk at https://dockr.ly/3ePqVcp

-------------------------------------------------------

Testing naveen/my-node-app:1.0...

Package manager:   npm
Target file:       /nodeapp/package.json
Project name:      docker_web_app
Docker image:      naveen/my-node-app:1.0

✔ Tested 57 dependencies for known vulnerabilities, no vulnerable paths found.

For more free scans that keep your images secure, sign up to Snyk at https://dockr.ly/3ePqVcp


Tested 2 projects, no vulnerable paths were found.


```