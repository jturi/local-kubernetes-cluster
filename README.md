### Create a Local Kubernetes Cluster
If you want to have a Kubernetes cluster to practice for your CKA/CKAD | If you want to build a Kubernetes cluster on your own | If you don't want to use minikube or Docker for Windows | Then his Vagrantfile will build a cluster on your local machine

### Prerequisites
- Memory: 12 or 16 GB
- CPU 4 ore more physical cores
- Install Vagrant > 2.2.9
- Install VirtualBox > 6.1
- Install kubectl > 1.18

### Troubleshooting
```
# If you get Hash Sum mismatch during apt install:
# Disable Hyper-V on your machine
# On Windows search for "Turn Windows Features"
# Untick Hyper-V option
# [ ] Hyper-V
```

### Build Cluster
```
# Navigate to local-kubernetes-cluster folder
# Build and configure VMs
vagrant up
```

### Use Cluster
```
# Copy .kube/config file from master
scp root@172.42.42.100:/home/vagrant/.kube/config config
Password: kubeadmin
mv ~/.kube/config ~/.kube/config.backup
cp config ~/.kube/config

# Try kubectl commands Unix:
alias k='kubectl '
k get nodes
k get nodes -o wide
k get po
k get ns
```

### Delete Cluster
```
# If you want to destroy the Virtual Machines built for this cluster use:
vagrant destroy -f
```

### System Resources
```
Before VMs build:
CPU: 9% (4 Core, 3.2 GHz)
MEM: 5.2GB (16GB)

After VMs build:
CPU: 15% (4 Core)
MEM: 9.4GB (16GB)
```

### Installing kubectl
```
### Unix ###
## Add this to your ~/.bashrc or ~/.bash_aliases file:
export PATH=~/bin:$PATH
# or
# echo "export PATH=~/bin:\$PATH" >> ~/.bashrc

## Install kubectl
export KUBECTL_VERSION=1.18.8
mkdir -p $HOME/bin/ && cd $HOME/bin/ && curl -L --remote-name-all https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && chmod 755 kubectl && cd -

## Check version
kubectl version
```
