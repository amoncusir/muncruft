#!/usr/bin/env sh

echo "Starting user_data.sh script"

echo "Install common packages"

apt -y -q update

apt install -y -q software-properties-common openjdk-16-jdk-headless

echo "Common packages installed"

java -version
