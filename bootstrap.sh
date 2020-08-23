#!/bin/bash

# If you get Hash Sum mismatch run cmd as administrator and execute:
# -Disable Windows Hyper-v

# Update hosts file
echo "[LOGGING] Echoing to: /tmp/apt_logs.txt"
echo "##################">> /tmp/apt_logs.txt

echo "[TASK 1] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
172.42.42.100 master.com master
172.42.42.101 worker1.com worker1
172.42.42.102 worker2.com worker2
EOF

# Install apt-transport-https pkg
export DEBIAN_FRONTEND=noninteractive
dpkg-reconfigure locales >/dev/null 2>/dev/null

echo "[TASK 2] Installing apt-transport-https pkg"
apt-get update -y -qq
apt-get install -y -qq apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

# Add he kubernetes sources list into the sources.list directory
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-$(lsb_release -cs) main
EOF
apt-get clean
apt-get update -y -qq

# Install Kubernetes
echo "[TASK 3] Install Kubernetes kubelet"
apt-get install -y -qq kubelet >> /tmp/apt_logs.txt
if ! [[ -x "$(command -v kubelet)" ]] ; then
  echo "[ERROR] kubelet not intalled"
else
  echo "[OK] kubelet installed"
fi
echo "[TASK 4] Install Kubernetes kubeadm"
apt-get install -y -qq kubeadm >> /tmp/apt_logs.txt
if ! [[ -x "$(command -v kubeadm)" ]] ; then
  echo "[ERROR] kubeadm not intalled"
else
  echo "[OK] kubeadm installed"
fi
echo "[TASK 5] Install Kubernetes kubectl"
apt-get install -y -qq kubectl >> /tmp/apt_logs.txt
if ! [[ -x "$(command -v kubectl)" ]] ; then
  echo "[ERROR] kubectl not intalled"
else
  echo "[OK] kubectl installed"
fi

# Start and Enable kubelet service
echo "[TASK 6] Enable and start kubelet service"
systemctl enable kubelet >/dev/null 2>&1
systemctl start kubelet
systemctl status kubelet | grep "Active:"


echo "[TASK 7] Install docker container engine"
apt-get install -y -qq apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get clean -qq
apt-get update -y -qq
apt-get install -y -qq docker-ce
if ! [[ -x "$(command -v docker)" ]] ; then
  echo "[ERROR] docker not intalled"
else
  echo "[OK] docker installed"
  docker -v
fi

# Add ccount to the docker group
usermod -aG docker vagrant


# Enable docker service
echo "[TASK 8] Enable and start docker service"
systemctl enable docker >/dev/null 2>&1
systemctl start docker
systemctl status docker | grep "Active:"

# Add sysctl settings
echo "[TASK 9] Add sysctl settings"
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system >/dev/null 2>&1

# Disable swap
echo "[TASK 10] Disable and turn off SWAP"
sed -i '/swap/d' /etc/fstab
swapoff -a

# Enable ssh password authentication
echo "[TASK 11] Enable ssh password authentication"
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo "[SSH CONF]: $(cat /etc/ssh/sshd_config | grep -i PermitRootLogin)"
echo "[SSH CONF]: $(cat /etc/ssh/sshd_config | grep -i PasswordAuthentication)"
systemctl restart sshd

# Set Root password
echo "[TASK 12] Set root password"
echo -e "kubeadmin\nkubeadmin" | passwd root

# Update vagrant user's bashrc file
echo "export TERM=xterm" >> /etc/bashrc

echo "[bootstrap.sh finished]"
