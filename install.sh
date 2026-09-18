#!/bin/bash
set -e

##
## NONET=true ./install.sh
##

NONET="${NONET:-false}"
JSON=/etc/docker/daemon.json

##
## DOCKER
##
which docker 2>/dev/null
if [[ $? -ne 0 ]]; then
  echo "[info] Installing docker."
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo usermod -aG docker $USER
  rm get-docker.sh
else
  echo "[info] Docker already installed."
fi

##
## DAEMON
##
if [[ $NONET == true ]] || [[ -d /docker ]]; then
    echo "[info] Using custom docker daemon settings."
    if [[ $NONET == true ]] && [[ -d /docker ]]; then
        echo "[info] Disabling Docker iptables and using /docker."
        DAEMON_JSON=$(cat <<'EOF'
{
  "iptables": false,
  "bridge": "none",
  "data-root": "/docker"
}
EOF
)
    elif [[ $NONET == true ]]; then
        echo "[info] Disabling Docker iptables."
        DAEMON_JSON=$(cat <<'EOF'
{
  "iptables": false,
  "bridge": "none"
}
EOF
)
    elif [[ -d /docker ]]; then
        echo "[info] Using /docker as the data-root."
        DAEMON_JSON=$(cat <<'EOF'
{
  "data-root": "/docker"
}
EOF
)
    fi
    sudo mkdir -p /etc/docker
    echo "[info] Setting: $JSON"
    sudo tee "$JSON" >/dev/null <<EOF
$DAEMON_JSON
EOF
else
    echo "[info] Using default docker daemon settings."
fi

echo "[info] Done."
exit 0
