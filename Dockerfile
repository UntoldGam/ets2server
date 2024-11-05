FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV STEAMCMD_DIR=/steamcmd
ENV ETS2_SERVER_DIR=/ets2

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    qemu-user \
    qemu-user-static \
    binfmt-support \
    libc6:i386 \
    libcurl4:i386 \
    libssl1.1:i386 \
    steamcmd \
    && rm -rf /var/lib/apt/lists/*

# Create necessary directories
RUN mkdir -p ${STEAMCMD_DIR} ${ETS2_SERVER_DIR}

# Expose ports
EXPOSE 27015/udp
EXPOSE 27016/udp

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR ${STEAMCMD_DIR}

ENTRYPOINT ["/entrypoint.sh"]
