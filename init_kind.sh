#!/bin/bash
set -ex
sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo usermod -a -G docker ec2-user

# Use newer version of kind for better compatibility
curl -sLo kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
sudo install -o root -g root -m 0755 kind /usr/local/bin/kind
rm -f ./kind

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm -f ./kubectl

# Add current user to docker group and refresh groups
sudo newgrp docker

kind create cluster --config kind.yaml