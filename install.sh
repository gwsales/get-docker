#!/bin/bash

which docker 2>/dev/null
if [[ $? -ne 0 ]]; then
  echo "[info] Installing docker."
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo usermod -aG docker $USER
  rm get-docker.sh
  if [[ -d /docker ]]; then
    echo "[info] Setting data-root to /docker vs /var/lib/docker."
    sudo cp data-root.json /etc/docker/daemon.json
  else
    echo "[info] Using default data-root /var/lib/docker."
  fi
else
  echo "[info] Docker already installed."
fi
echo "[info] Done."
exit 0
