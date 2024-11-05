FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV STEAMCMD_DIR=/steamcmd
ENV ETS2_SERVER_DIR=/ets2

# Add multiarch support for i386
RUN dpkg --add-architecture i386 && apt-get update

# Install dependencies and SteamCMD
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    gcc \
    g++ \
    libcurl4 \
    libssl-dev \
    software-properties-common && \
    add-apt-repository multiverse && \
    apt-get update && apt-get install -y --no-install-recommends steamcmd && \
    rm -rf /var/lib/apt/lists/*

# Create necessary directories
RUN mkdir -p ${STEAMCMD_DIR} ${ETS2_SERVER_DIR}

# Expose ports
EXPOSE 27015/udp
EXPOSE 27016/udp

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR ${STEAMCMD_DIR}

ENTRYPOINT ["/entrypoint.sh"]
