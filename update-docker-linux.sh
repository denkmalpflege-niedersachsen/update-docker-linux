#!/usr/bin/env bash
set -euo pipefail

ARCH=$(dpkg --print-architecture)

echo "==> Updating Docker Engine..."

sudo apt update
sudo apt install -y ca-certificates curl

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

sudo tee /etc/apt/sources.list.d/docker.sources > /dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: ${ARCH}
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
sudo apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

echo "Docker Engine updated: $(docker --version)"

echo "==> Updating Docker Desktop..."

DEB_URL="https://desktop.docker.com/linux/main/${ARCH}/docker-desktop-${ARCH}.deb"
TMP_FILE=$(mktemp --suffix=.deb)
trap 'rm -f "$TMP_FILE"' EXIT

curl -fsSL "$DEB_URL" -o "$TMP_FILE"
# apt may show a harmless error at the end of install — this is expected
sudo apt install -y "$TMP_FILE"

echo "Docker Desktop updated successfully"
