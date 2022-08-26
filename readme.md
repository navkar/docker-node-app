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