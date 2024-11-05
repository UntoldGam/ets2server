FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV STEAMCMD_DIR=/steamcmd
ENV ETS2_SERVER_DIR=/ets2

# Install QEMU and related tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    qemu-user \
    qemu-user-static \
    binfmt-support \
    curl \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install SteamCMD manually (x86 binaries will run under QEMU)
RUN mkdir -p ${STEAMCMD_DIR} && \
    cd ${STEAMCMD_DIR} && \
    curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -xz

# Expose ports
EXPOSE 27015/udp
EXPOSE 27016/udp

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR ${STEAMCMD_DIR}

ENTRYPOINT ["/entrypoint.sh"]