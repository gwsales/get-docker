#!/bin/bash

which docker 2>/dev/null
if [[ $? -ne 0 ]]; then
    ## Docker not installed
    if [[ ! -f get-docker.sh ]]; then
        curl -fsSL https://get.docker.com -o get-docker.sh
        sudo sh get-docker.sh
        sudo usermod -aG docker $USER
    else
        echo "[warn] get-docker.sh might have alrady ran"
    fi
else
    echo "[info] Docker already installed"
fi
