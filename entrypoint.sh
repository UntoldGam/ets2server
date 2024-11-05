#!/bin/bash
set -e

# Set default values for environment variables if not set
STEAM_USER=${STEAM_USER:-anonymous}
STEAM_PASS=${STEAM_PASS:-""}
SERVER_TOKEN=${SERVER_TOKEN}
MAX_PLAYERS=${MAX_PLAYERS:-8}
SERVER_NAME=${SERVER_NAME:-"ETS2 Dedicated Server"}
SERVER_DESCRIPTION=${SERVER_DESCRIPTION:-"Dedicated ETS2 Server"}
SERVER_PASSWORD=${SERVER_PASSWORD:-""}

# Download or update the ETS2 server
${STEAMCMD_DIR}/steamcmd.sh +login ${STEAM_USER} ${STEAM_PASS} \
    +force_install_dir ${ETS2_SERVER_DIR} \
    +app_update 1948160 validate \
    +quit

# Start the server
cd ${ETS2_SERVER_DIR}
./bin/linux_x64/eurotrucks2_server \
    -server \
    -server_auth_token ${SERVER_TOKEN} \
    -server_max_playerrs ${MAX_PLAYERS} \
    -server_name "${SERVER_NAME}" \
    -server_description "${SERVER_DESCRIPTION}" \
    -server_password "${SERVER_PASSWORD}"
