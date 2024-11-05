#!/bin/bash
set -e

# Run SteamCMD under QEMU
/usr/bin/qemu-x86_64-static ${STEAMCMD_DIR}/steamcmd.sh +login anonymous \
    +force_install_dir ${ETS2_SERVER_DIR} \
    +app_update 1948160 validate +quit

# Start the ETS2 server
${ETS2_SERVER_DIR}/bin/linux_x64/eurotrucks2_server \
    -server \
    -server_auth_token ${SERVER_TOKEN} \
    -server_max_playerrs ${MAX_PLAYERS} \
    -server_name "${SERVER_NAME}" \
    -server_description "${SERVER_DESCRIPTION}" \
    -server_password "${SERVER_PASSWORD}"