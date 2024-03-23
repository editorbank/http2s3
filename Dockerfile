FROM docker.io/library/nginx:alpine

MAINTAINER editorbank

ENV HELLO_NAME=FromDockerfile

ENV NGINX_CONF=/etc/nginx/nginx.conf
ENV NGINX_CONF_D=/etc/nginx/conf.d/
ENV NGINX_DEFAULT_D=/etc/nginx/default.d/
ENV NGINX_HTML=/usr/share/nginx/html/

EXPOSE 80/tcp

COPY ./html/*       $NGINX_HTML
COPY ./conf.d/*     $NGINX_CONF_D
COPY ./js/*         $NGINX_CONF_D
COPY ./default.d/*  $NGINX_DEFAULT_D
COPY ./nginx.conf/* $NGINX_CONF/../

CMD ["nginx", "-c", "/etc/nginx/http2s3.nginx.conf"]
