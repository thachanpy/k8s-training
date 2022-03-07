#!/bin/sh

USER=$1

sudo useradd -m -s /bin/bash -U $USER -u 666 --group sudo
sudo cp -pr /home/vagrant/.ssh /home/${USER}/.ssh
sudo mv /tmp/id_rsa.pub /home/${USER}/.ssh/authorized_keys
sudo chown -R ${USER}:${USER} /home/${USER}

# disable swap 
sudo swapoff -a
# keeps the swaf off during reboot
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release



sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt-get update -y
sudo apt-get install docker-ce -y
sudo echo '{"exec-opts": ["native.cgroupdriver=systemd"]}' | sudo tee -a /etc/docker/daemon.json
sudo systemctl restart docker
sudo systemctl enable docker

sudo usermod -aG docker $USER
