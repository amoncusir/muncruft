#!/usr/bin/env sh

## CONFIG #####################################################################

export DEBIAN_FRONTEND=noninteractive

## CONSTANTS ##################################################################

RCON_PASSWORD="${rcon_password}"

%{ for prop in environment_vars ~}
${prop["key"]}="${prop["value"]}"
%{ endfor ~}

#SYSTEMD_CONFIG="https://raw.githubusercontent.com/amoncusir/muncruft/main/muncruft.service"
#SYSTEMD_CONFIG="https://raw.githubusercontent.com/amoncusir/muncruft/main/muncruft.service"

MINECRAFT_SERVER_BIN="https://launcher.mojang.com/v1/objects/a16d67e5807f57fc4e550299cf20226194497dc2/server.jar"
MINECRAFT_HOME="/opt/minecraft"

###############################################################################

echo "Starting user_data.sh script"

echo "Install common packages"

apt-get -yq update
apt-get -yq upgrade

apt-get install -yq

echo "Common packages installed"

###############################################################################


