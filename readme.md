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

### docker networking

* `ifconfig` - short for interface config -  Ifconfig is used to configure the kernel-resident network interfaces. It is used at boot time to set up interfaces as necessary.

```
bridge0: flags=8822<BROADCAST,SMART,SIMPLEX,MULTICAST> mtu 1500
	options=63<RXCSUM,TXCSUM,TSO4,TSO6>
	ether 82:7e:09:66:bc:01 
	Configuration:
		id 0:0:0:0:0:0 priority 0 hellotime 0 fwddelay 0
		maxage 0 holdcnt 0 proto stp maxaddr 100 timeout 1200
		root id 0:0:0:0:0:0 priority 0 ifcost 0 port 0
		ipfilter disabled flags 0x0
	member: en1 flags=3<LEARNING,DISCOVER>
	        ifmaxaddr 0 port 10 priority 0 path cost 0
	member: en2 flags=3<LEARNING,DISCOVER>
	        ifmaxaddr 0 port 11 priority 0 path cost 0
	member: en3 flags=3<LEARNING,DISCOVER>
	        ifmaxaddr 0 port 12 priority 0 path cost 0
	member: en4 flags=3<LEARNING,DISCOVER>
	        ifmaxaddr 0 port 9 priority 0 path cost 0
	media: <unknown type>
	status: inactive
```


```bash
$ docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
459511c923b6   bridge    bridge    local
4985c27a2c40   host      host      local
a111ae20d120   none      null      local

$ docker network inspect bridge
[
    {
        "Name": "bridge",
        "Id": "459511c923b6b3e38548fd93ef69812e3affa0194b117b964b94c43cda3b57f8",
        "Created": "2022-08-26T22:07:07.573813889Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.17.0.0/16",
                    "Gateway": "172.17.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {},
        "Options": {
            "com.docker.network.bridge.default_bridge": "true",
            "com.docker.network.bridge.enable_icc": "true",
            "com.docker.network.bridge.enable_ip_masquerade": "true",
            "com.docker.network.bridge.host_binding_ipv4": "0.0.0.0",
            "com.docker.network.bridge.name": "docker0",
            "com.docker.network.driver.mtu": "1500"
        },
        "Labels": {}
    }
]

```

### docker network assignment

![docker-network-assignment](/images/network-assignment.png)

#### assignment

```
Create a bridge network called frontend that will be publicly accessible.
Create a second bridge network called localhost that will be internal.
Deploy a MySQL container called database that will use the localhost network. Use the mysql 5.7 image:

    Use the -e flag to set MYSQL_ROOT_PASSWORD to "P4ssW0rd0!".
    The MySQL container should run in the background.

Next, deploy a second container called frontend-app. Connect it to the frontend network using the --network flag. Use the latest Nginx image. The Nginx container should run in the background.

Once the Nginx container is created, connect it to the localhost network.
```


```bash
$ docker network create frontend
db0a0b0ae92039fadfc803629ea8e302f5188e39ae8c12208578f4132dcf3610
$ docker network inspect frontend

$ docker network create localhost --internal
53460452e090a192f9f39eba0377609c0fa9e01dc57cc1e66d6af2028a68f004

$ docker container run -d --name database --network localhost -e MYSQL_ROOT_PASSWORD=P4ssW0rd0! mysql:5.7
$ docker container ls
CONTAINER ID   IMAGE       COMMAND                  CREATED          STATUS          PORTS     NAMES
eb3c772c2d92   mysql:5.7   "docker-entrypoint.s…"   12 seconds ago   Up 11 seconds             database

$ docker container run -d --name=frontend-app --network frontend nginx

$ docker container lsCONTAINER ID   IMAGE       COMMAND                  CREATED         STATUS         PORTS     NAMES
2f99394fcd18   nginx       "/docker-entrypoint.…"   2 minutes ago   Up 2 minutes   80/tcp    frontend-app
eb3c772c2d92   mysql:5.7   "docker-entrypoint.s…"   3 minutes ago   Up 3 minutes             database

$ docker network connect localhost frontend-app

$ docker container inspect frontend-app
```

## docker storage

Use a volume for persistent data (Volumes are first-class citizens)

1. Create the volume.
1. Create your container.

##### Third party drivers

1. Block storage
2. File storage
3. Object storage - AWS S3, OpenStack swift

```bash
$ docker volume ls
DRIVER    VOLUME NAME

$ docker volume create naveen-new-volume
naveen-new-volume

$ docker volume inspect naveen-new-volume
[
    {
        "CreatedAt": "2022-08-27T14:29:33Z",
        "Driver": "local",
        "Labels": {},
        "Mountpoint": "/var/lib/docker/volumes/naveen-new-volume/_data",
        "Name": "naveen-new-volume",
        "Options": {},
        "Scope": "local"
    }
]

$ docker volume create vol04 --label location=austin --label region=east

$ docker volume inspect vol04
[
    {
        "CreatedAt": "2022-08-27T15:38:42Z",
        "Driver": "local",
        "Labels": {
            "location": "austin",
            "region": "east"
        },
        "Mountpoint": "/var/lib/docker/volumes/vol04/_data",
        "Name": "vol04",
        "Options": {},
        "Scope": "local"
    }
]
```

### Bind mounts 

Bind to a local directory on the host.

[bind-mounts](https://docs.docker.com/storage/bind-mounts/)

Consider a case where you have a directory source and that when you build the source code, the artifacts are saved into another directory, source/target/. You want the artifacts to be available to the container at /app/, and you want the container to get access to a new build each time you build the source on your development host. Use the following command to bind-mount the target/ directory into your container at /app/. Run the command from within the source directory. The $(pwd) sub-command expands to the current working directory on Linux or macOS hosts

```bash
$ mkdir bind_target

$ docker container run -d --name=nginx-bind-mount --mount type=bind,source="$(pwd)"/bind_target,target=/app nginx

$ docker container inspect nginx-bind-mount
   "Mounts": [
            {
                "Type": "bind",
                "Source": "/Users/navkar/source/repos/dockerize/node-image/bind_target",
                "Destination": "/app",
                "Mode": "",
                "RW": true,
                "Propagation": "rprivate"
            }
        ],

```

#### Use a bind mount with compose

```yaml
version: "3.9"
services:
  frontend:
    image: node:lts
    volumes:
      - type: bind
        source: ./static
        target: /opt/app/staticvolumes:
  myapp:
```


## references

* [nodejs-docker-webapp](https://nodejs.org/en/docs/guides/nodejs-docker-webapp/#dockerignore-file)
* [Generate the SBOM for Docker images](https://docs.docker.com/engine/sbom/)

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

```
docker image inspect nginx

docker containers --help

docker logs 8c802a5f2680

arn:aws:s3:::com.myidjoey.az103
```


