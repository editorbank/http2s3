FROM docker.io/library/nginx:alpine

ENV HELLO_NAME=FromDockerfile

#ENV NGINX_CONF=/etc/nginx/before.nginx.conf
#ENV NGINX_CONF_D=/etc/nginx/conf.d/
#ENV NGINX_DEFAULT_D=/etc/nginx/default.d/
#ENV NGINX_HTML=/usr/share/nginx/html/

EXPOSE 8000/tcp

COPY ./add_to_image/usr/share/nginx/html/* /usr/share/nginx/html/
COPY ./add_to_image/etc/nginx/conf.d/*     /etc/nginx/conf.d/
COPY ./add_to_image/etc/nginx/default.d/*  /etc/nginx/default.d/
COPY ./add_to_image/etc/nginx/*            /etc/nginx/

CMD ["nginx", "-c", "/etc/nginx/before.nginx.conf"]
