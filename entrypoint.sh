#!/bin/bash
set -e
USER=sshuttle

# Check if the SSH_AUTHORIZED_KEYS variable is not empty
if [ -n "$SSH_AUTHORIZED_KEYS" ]; then
    echo "Adding SSH authorized keys..."
    mkdir -p /home/$USER/.ssh
    echo "$SSH_AUTHORIZED_KEYS" > /home/$USER/.ssh/authorized_keys
    chown $USER:$USER -R /home/$USER/.ssh
    chmod 700 /home/$USER/.ssh
    chmod 600 /home/$USER/.ssh/authorized_keys
else
    echo "No SSH_AUTHORIZED_KEYS environment variable set. Skipping..."
fi

# Start SSH Daemon
exec /usr/sbin/sshd -D -e "$@"