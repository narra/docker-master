FROM phusion/passenger-ruby26
MAINTAINER Michal Mocnak <michal@narra.eu>
LABEL Vendor="narra" Version="1.0"

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Add custom scripts
ADD . /narra_build

# Fix permissions on scripts
RUN chmod +x -R /narra_build/scripts

# Install NARRA master node
RUN /narra_build/scripts/install.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
