FROM alpine:latest
RUN apk add --no-cache bash curl
WORKDIR /app
COPY setup_kibana.sh /app/
COPY kibana_project.ndjson /app/
RUN chmod +x /app/setup_kibana.sh
# Run setup and then keep the container alive to avoid K8s restart loops
CMD ["/bin/bash", "-c", "/app/setup_kibana.sh && tail -f /dev/null"]
