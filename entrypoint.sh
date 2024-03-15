#!/bin/bash
set -e

# Set USER to its current value or to 'sshuttle' if it's not set
USER=${USER:-sshuttle}

# Create the user if it doesn't exist, set home directory and don't assign a password
if ! id -u $USER > /dev/null 2>&1; then
    echo "User $USER does not exist; creating..."
    useradd -m $USER
    echo "User $USER created."
else
    echo "User $USER exists."
fi

# Log the user
echo "Running as user: $USER"

# Check if the SSH_AUTHORIZED_KEYS variable is not empty
if [ -n "$SSH_AUTHORIZED_KEYS" ]; then
    echo "Adding SSH authorized keys..."
    
    # Create .ssh directory if it doesn't exist
    mkdir -p /home/$USER/.ssh
    echo "Created .ssh directory..."
    
    # Write the authorized keys
    echo "$SSH_AUTHORIZED_KEYS" > /home/$USER/.ssh/authorized_keys
    echo "Wrote authorized_keys file..."
    
    # Print a portion of the key for verification
    echo "Key starts with $(echo "$SSH_AUTHORIZED_KEYS" | head -c 20)..."
    echo "Key ends with $(echo "$SSH_AUTHORIZED_KEYS" | tail -c 20)..."
    echo "Key has $(echo "$SSH_AUTHORIZED_KEYS" | wc -c) total characters."
    
    # Set permissions
    chown $USER:$USER -R /home/$USER/.ssh
    chmod 700 /home/$USER/.ssh
    chmod 600 /home/$USER/.ssh/authorized_keys
    echo "Set permissions on .ssh directory and authorized_keys file..."
else
    echo "No SSH_AUTHORIZED_KEYS environment variable set. Skipping..."
fi

# Log the SSH daemon start
echo "Starting SSH daemon..."

# Start SSH Daemon
exec /usr/sbin/sshd -D -e "$@"
