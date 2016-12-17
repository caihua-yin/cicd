#!/bin/bash

# Exit immediately on non-zero return code
set -e

echo "Installing Ansible..."
sudo apt-get install -y software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y --force-yes ansible
