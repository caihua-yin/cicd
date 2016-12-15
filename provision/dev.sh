#!/bin/bash

# Exit immediately on non-zero return code
set -e

echo "Installing Ansible..."
apt-get install -y --force-yes ansible
