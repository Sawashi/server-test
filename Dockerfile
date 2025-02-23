# Use Ubuntu as the base image
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y openssh-server sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create a new user for security reasons
RUN useradd -m -s /bin/bash ubuntuuser && \
    echo 'ubuntuuser:password123' | chpasswd && \
    usermod -aG sudo ubuntuuser

# Set up SSH
RUN mkdir /var/run/sshd
EXPOSE 22

# Allow SSH password authentication
RUN sed -i 's/^#\?PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]
