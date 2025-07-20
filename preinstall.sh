#!/bin/bash

set -e

echo "Updating system packages..."
sudo apt update
sudo apt upgrade -y

echo "Installing dependencies..."
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

echo "Setting up Docker repository..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "Adding Docker source to apt..."
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Updating package index..."
sudo apt update

echo "Installing Docker and plugins..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Docker version:"
docker --version

echo "Adding user to docker group..."
sudo usermod -aG docker "$USER"

echo "Installing Nginx..."
sudo apt install nginx -y

echo "Installation complete. Please reboot or re-login for docker group changes to take effect."
