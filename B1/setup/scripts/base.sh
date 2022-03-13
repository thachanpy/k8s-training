#!/bin/sh

sudo useradd -m -s /bin/bash -U $USER -u 666 --group sudo
sudo cp -pr /home/vagrant/.ssh /home/${USER}/.ssh
sudo mv /tmp/id_rsa.pub /home/${USER}/.ssh/authorized_keys
sudo chown -R ${USER}:${USER} /home/${USER}

# disable swap 
sudo swapoff -a
# keeps the swaf off during reboot
sudo sed -i '/swap/ s/^\(.*\)$/#\1/g' /etc/fstab

sudo sed -i '/^nameserver/c nameserver 8.8.8.8' /etc/resolv.conf
sudo sed -i "s|http://us.|http://|g" /etc/apt/sources.list

sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release net-tools

IP_ADDRESS=`hostname -I | awk '{print $2}'`

sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt-get update -y
sudo apt-get install docker-ce -y
sudo echo '{"exec-opts": ["native.cgroupdriver=systemd"]}' | sudo tee -a /etc/docker/daemon.json
sudo systemctl restart docker
sudo systemctl enable docker

sudo usermod -aG docker $USER

# Install Kubernetes components
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet=${K8S_VERSION}-00 kubeadm=${K8S_VERSION}-00 kubectl=${K8S_VERSION}-00
sudo apt-mark hold kubelet kubeadm kubectl

sudo sed -i "s|/usr/bin/kubelet|/usr/bin/kubelet --node-ip=${IP_ADDRESS}|g" /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

sudo systemctl daemon-reload
sudo systemctl enable kubelet
sudo systemctl restart kubelet
