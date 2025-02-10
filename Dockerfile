FROM debian:jessie-slim

ENV DEBIAN_FRONTEND=noninteractive

# Configure archived Debian Jessie repositories
# Signature verification is disabled because we're using archive.debian.org,
# which uses expired keys that can't be renewed. This is safe as the archive
# is maintained by Debian and its content is immutable.
# HTTPS is apparently not supported, though.
RUN echo "deb http://archive.debian.org/debian jessie main" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/backports.list && \
    echo "deb http://archive.debian.org/debian-security jessie/updates main" >> /etc/apt/sources.list && \
    echo "Acquire::Check-Valid-Until false;" > /etc/apt/apt.conf.d/10no-check-valid-until

# Install Java 8 with IcedTea plugin (32-bit)
RUN mkdir -p /usr/share/man/man1 && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get -t jessie-backports install -y --no-install-recommends --allow-unauthenticated \
        openjdk-8-jdk:i386 \
        icedtea-plugin:i386 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-i386
ENV PATH=$JAVA_HOME/bin:$PATH

WORKDIR /data

CMD ["/bin/bash"]
