 #!/bin/sh

PRIVATE_KEY=/tmp/id_rsa

sudo chmod 400 ${PRIVATE_KEY}

sudo ls -la /vagrant

sudo mkdir -p /home/${USER}/.kube
sudo scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ${PRIVATE_KEY} ${USER}@${MASTER_IP_ADDRESS}:/tmp/config /home/${USER}/.kube/config
sudo chown -R ${USER}:${USER} /home/${USER}/.kube
sudo chmod 644 /home/${USER}/.kube/config

JOIN_CLUSTER_FILE=/tmp/join.sh

sudo scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ${PRIVATE_KEY} ${USER}@${MASTER_IP_ADDRESS}:${JOIN_CLUSTER_FILE} ${JOIN_CLUSTER_FILE}

sudo chmod +x ${JOIN_CLUSTER_FILE}
sudo ${JOIN_CLUSTER_FILE}

export KUBECONFIG=/home/${USER}/.kube/config
kubectl label node $(hostname -s) node-role.kubernetes.io/worker=worker

sudo systemctl restart systemd-resolved
sudo swapoff -a && sudo systemctl daemon-reload && sudo systemctl restart kubelet
