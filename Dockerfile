FROM nginx:latest
# https://docs.docker.com/engine/reference/builder/#volume
VOLUME ["/usr/share/nginx/html/"]