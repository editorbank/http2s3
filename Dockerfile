FROM docker.io/library/nginx:alpine

MAINTAINER editorbank

ENV HELLO_NAME=FromDockerfile

ENV NGINX_CONF=/etc/nginx/nginx.conf
ENV NGINX_CONF_D=/etc/nginx/conf.d/
ENV NGINX_DEFAULT_D=/etc/nginx/default.d/
ENV NGINX_HTML=/usr/share/nginx/html/

EXPOSE 80/tcp

COPY ./usr/share/nginx/html/* $NGINX_HTML
COPY ./etc/nginx/conf.d/*     $NGINX_CONF_D
COPY ./etc/nginx/default.d/*  $NGINX_DEFAULT_D
COPY ./etc/nginx/*            $NGINX_CONF/../

CMD ["nginx", "-c", "/etc/nginx/http2s3.nginx.conf"]
