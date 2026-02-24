FROM alpine:latest
RUN apk add --no-cache bash curl
WORKDIR /app
COPY . /app
CMD ["ls", "-R"]
