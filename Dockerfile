# Use Ubuntu as the base image
FROM ubuntu:20.04

# Install SSH server
RUN apt-get update && \
    apt-get install -y openssh-server sudo && \
    apt-get clean

# Create a user
RUN useradd -m -s /bin/bash ubuntuuser && \
    echo 'ubuntuuser:password123' | chpasswd && \
    usermod -aG sudo ubuntuuser

# Configure SSH to use port 10022
RUN sed -i 's/^#Port 22/Port 10022/' /etc/ssh/sshd_config

# Ensure the SSH directory exists
RUN mkdir -p /run/sshd

# Expose port 10022
EXPOSE 10022

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]
