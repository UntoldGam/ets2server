# Use a lightweight ARM64 base image
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV STEAMCMD_DIR=/steamcmd
ENV ETS2_SERVER_DIR=/ets2

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    lib32gcc1 \
    lib32stdc++6 \
    wget \
    curl \
    ca-certificates \
    libtbb2 \
    libcurl4-gnutls-dev:i386 \
    libcurl4-gnutls-dev \
    libssl-dev \
    steamcmd && \
    rm -rf /var/lib/apt/lists/*

# Create necessary directories
RUN mkdir -p ${STEAMCMD_DIR} ${ETS2_SERVER_DIR}

# Download and install SteamCMD
RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz -O /tmp/steamcmd.tar.gz && \
    tar -xvzf /tmp/steamcmd.tar.gz -C ${STEAMCMD_DIR} && \
    rm /tmp/steamcmd.tar.gz

# Expose ports
EXPOSE 27015/udp
EXPOSE 27016/udp

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set working directory
WORKDIR ${STEAMCMD_DIR}

ENTRYPOINT ["/entrypoint.sh"]
