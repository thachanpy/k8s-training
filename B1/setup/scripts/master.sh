 #!/bin/sh

sudo kubeadm init --apiserver-advertise-address=${MASTER_IP_ADDRESS} --pod-network-cidr=${POD_CIDR} --node-name $(hostname -s) --kubernetes-version=${K8S_VERSION} --ignore-preflight-errors=NumCPU

sudo mkdir -p /home/${USER}/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/${USER}/.kube/config

sudo chown -R ${USER}:${USER} /home/${USER}/.kube

JOIN_CLUSTER_FILE=/tmp/join.sh

sudo kubeadm token create --print-join-command > ${JOIN_CLUSTER_FILE}
sudo chmod +x ${JOIN_CLUSTER_FILE}

sudo cp -i /etc/kubernetes/admin.conf /tmp/config
sudo chmod 644 /tmp/config

kubectl apply -f https://projectcalico.docs.tigera.io/manifests/calico.yaml

sudo systemctl restart systemd-resolved
sudo swapoff -a && sudo systemctl daemon-reload && sudo systemctl restart kubelet

