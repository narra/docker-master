FROM phusion/passenger-ruby25
MAINTAINER Michal Mocnak <michal@narra.eu>
LABEL Vendor="narra" Version="1.0"

# Set correct environment variables.
#ENV HOME /root

# Set narra build env
COPY . /narra-build

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Fix permissions on scripts
RUN chmod +x -R /narra-build/scripts

# Install NARRA master node
RUN /narra-build/scripts/install.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
