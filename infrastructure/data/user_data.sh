#!/usr/bin/env sh

## CONFIG #####################################################################

export DEBIAN_FRONTEND=noninteractive

## CONSTANTS ##################################################################

RCON_PASSWORD="${rcon_password}"

%{ for prop in environment_vars ~}
${prop["key"]}="${prop["value"]}"
%{ endfor ~}

## Script #####################################################################

echo "Starting user_data.sh script"

###############################################################################

echo "Install common packages"

apt-get -yq update
apt-get -yq upgrade

apt-get install -yq git curl wget \
    docker.io

echo "Common packages installed"

###############################################################################


