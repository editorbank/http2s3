FROM docker.io/library/nginx:alpine
EXPOSE 8000/tcp
COPY ./src /

CMD ["nginx", "-c", "/tmp/nginx.conf"]
ENTRYPOINT ["/app/run.sh"]
