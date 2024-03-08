# SSHuttle Pod

SSHuttle Pod is specifically designed to be used with [sshuttle](https://github.com/sshuttle/sshuttle) as an SSH Server inside a Docker container.

## Requirements

1. Docker: A tool designed to facilitate application development and deployment.
2. Docker-compose: A tool to run multi-container applications.
3. [sshuttle](https://github.com/sshuttle/sshuttle): a transparent proxy server that works as a poor man's VPN.

## Getting Started

### Build Docker image

To build Docker image:

```bash
npm run docker-build
```

This will generate a new Docker image named `sshuttle:latest`.

### Push Docker image to Docker Hub

Once the Docker image is built successfully, push the Docker image to Docker Hub:

```bash
npm run docker-push
```

This pushes the Docker image to your Docker Hub repository.

### Running Docker Container with Docker Compose

Start the Docker container using Docker Compose:

```bash
docker-compose up
```

Your SSH server should now be running and visible on the exposed port 2222.

## Environment variables

`SSH_AUTHORIZED_KEYS`: this is used to set the SSH public keys that will be used by the server for authorization.

Here's an example of how to define it:

```env
SSH_AUTHORIZED_KEYS="ssh-rsa YOUR_RSA_PUBLIC_KEY"
```
