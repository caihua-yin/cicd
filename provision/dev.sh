#!/bin/bash

# Exit immediately on non-zero return code
set -e

echo "Install Ansible..."
sudo apt-get install -y software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible

echo "Install docker-engine..."
docker_repo="deb https://apt.dockerproject.org/repo ubuntu-trusty main"
docker_repo_file="/etc/apt/sources.list.d/apt_dockerproject_org_repo.list"
grep "$docker_repo" $docker_repo_file || \
        (sudo sh -c "echo $docker_repo >> $docker_repo_file" && \
        sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
        sudo apt-get update)
sudo apt-get install -y docker-engine
# Add user `vagrant` to a secondary group `docker`, so it can execute docker client command without sudo
sudo usermod -a -G docker vagrant
# Script to remove stopped containers and dangling images
sudo ln -s /vagrant/github.com/caihua-yin/cicd/provision/bins/remove_dangling_images.sh /usr/local/bin/remove_dangling_images.sh
sudo ln -s /vagrant/github.com/caihua-yin/cicd/provision/bins/remove_stopped_containers.sh /usr/local/bin/remove_stopped_containers.sh

echo "Install docker compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Install and configure golang..." # See https://golang.org/doc/install
VERSION=1.7.4
OS=linux
ARCH=amd64
wget https://storage.googleapis.com/golang/go$VERSION.$OS-$ARCH.tar.gz --no-check-certificate
sudo tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz
export GOROOT=/usr/local/go
export GOPATH=$HOME/gopath
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
grep GOROOT $HOME/.profile || cat >> $HOME/.profile << EOL
export GOROOT=/usr/local/go
export GOPATH=$HOME/gopath
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
EOL
rm -f go$VERSION.$OS-$ARCH.tar.gz

echo "Install python-pip..."
sudo apt-get install -y python-pip

echo "Install virtualenv..."
sudo pip install virtualenv

echo "Install cqlsh(Cassandra client)..."
sudo pip install cqlsh==4.1.1

echo "Generate SSH key pair..."
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa # Alternative way: echo -e "\n\n\n" | ssh-keygen -t rsa

echo "Install postgresql-client-common (where psql included)..."
sudo apt-get install -y postgresql-client-common

echo "Install jq (JSAON Query)..."
sudo apt-get install -y jq

echo "Install apt-file..."
sudo apt-get install -y apt-file

echo "Install unzip..."
sudo apt-get install -y unzip

echo "Install xmllint..."
sudo apt-get install -y libxml2-utils # Usage: echo "<xml string>" | xmllint --format -

HOSTS="/etc/hosts"
echo "Update $HOSTS..."
grep 192.168.33.21 $HOSTS || cat >> $HOSTS << EOL
192.168.33.21 prod01
192.168.33.22 prod02
192.168.33.23 prod03
EOL
