# Use an official Python runtime as a parent image
FROM python:3.10.13-slim

# Install OpenSSH
RUN apt-get update && \
    apt-get install -y openssh-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create a non-root user
RUN useradd -m -d /home/sshuttle sshuttle

# Configure SSH
RUN mkdir /var/run/sshd
# RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key

# Change the default SSH port
RUN sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config

# Disable root login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
RUN sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# Enable ssh-rsa algorithm
RUN echo 'PubkeyAcceptedKeyTypes +ssh-rsa' >> /etc/ssh/sshd_config

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the working directory
WORKDIR /home/sshuttle

# Expose the SSH port
EXPOSE 2222

# Run the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]