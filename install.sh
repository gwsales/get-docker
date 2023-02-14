#!/usr/bin/env bash
groups | grep -q docker
if [[ $? -eq 0 ]]; then
    echo "[info] Docker already installed: user group"
elif [[ -f /opt/.git-docker ]]; then
    echo "[info] Docker already installed: /opt/.git-docker"
else
    sudo curl -fsSL https://get.docker.com -o /opt/get-docker.sh
    sudo sh ./get-docker.sh
    sudo usermod -aG docker $USER
    sudo rm /opt/get-docker.sh
    sudo touch /opt/.git-docker
fi
