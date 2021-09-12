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

apt-get -y -q update

apt-get install -yq software-properties-common \
    git make gcc curl wget \
    openjdk-16-jdk-headless

echo "Common packages installed"

###############################################################################

echo "Preparing environment"

useradd -r -m -U -d "$MINECRAFT_HOME" -s /bin/bash minecraft

su minecraft -c "mkdir $MINECRAFT_HOME/{backups,tools,server}"

###############################################################################

echo "Install mcrcon client"

install_mcrcon() {

    tmp="$1"
    current="$(pwd)"

    cd "$tmp" || exit 1

    git clone https://github.com/Tiiffi/mcrcon.git mcrcon
    cd mcrcon || exit 1

    make && make install

    cd "$current" || exit 1
}

TMP_DIR_MCRCON=$(mktemp -d /tmp/XXXXXXX)

install_mcrcon "$TMP_DIR_MCRCON"

rm -rf "$TMP_DIR_MCRCON"

mcrcon -v

###############################################################################

echo "Preparing Minecraft"

cd /opt/minecraft || exit 1

echo "On Working directory: $(pwd)"

wget -O minecraft.jar "$MINECRAFT_SERVER_BIN"
wget -O server.properties "$MINECRAFT_SERVER_CONFIG"

mv ./minecraft.jar ./server/
mv ./server.properties ./server/

cat 'eula=true' > ./server/eula.txt

#wget -O minecraft.service "$SYSTEMD_CONFIG"
