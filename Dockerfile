FROM alpine:latest
RUN apk add --no-cache bash curl
WORKDIR /app
# Kopírujeme skripty aj dáta
COPY setup_kibana.sh /app/
COPY kibana_project.ndjson /app/
RUN chmod +x /app/setup_kibana.sh
CMD ["/app/setup_kibana.sh"]
