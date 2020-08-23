#!/bin/bash

# Join worker nodes to the Kubernetes cluster
echo "[WORKER TASK 1] Join node to Kubernetes Cluster"
apt-get install -y sshpass >> /tmp/apt_logs.txt
sshpass -p "kubeadmin" scp -o StrictHostKeyChecking=no master.com:/joincluster.sh /joincluster.sh
# bash /joincluster.sh >/dev/null 2>&1
bash /joincluster.sh
echo "[bootstrap_worker.sh finished]"
