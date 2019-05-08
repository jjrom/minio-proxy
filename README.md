# minio-proxy
nginx proxy to [minio](https://min.io) with access to /minio disable for security reason

## Installation

### From dockerhub

    docker pull jjrom/minio-proxy

### Build from source
Launch the following command and go for a coffee break

    docker build -t jjrom/minio-proxy .

## Start container

Using docker-compose (will also deploy minio/minio container on port 9000)

    docker-compose up -d

Using docker

    docker run -d -p 8000:80 jjrom/minio-proxy

